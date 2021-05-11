module Rack
  class Attack
    FAIL2BAN_LIST = %w[
      /etc/passwd
      wp-admin
      wp-login
      wp-includes
      .php
    ].freeze

    FAIL2BAN_REGEX = Regexp.union(FAIL2BAN_LIST).freeze

    # Throttle /csp_reports requests by IP (5rpm)
    throttle("csp_reports req/ip", limit: 5, period: 1.minute) do |req|
      req.ip if req.path == "/csp_reports"
    end

    unless ENV["SKIP_REQ_LIMITS"].to_s.in? %w[true yes 1]
      # Throttle requests that issue a verification code by IP (5rpm)
      throttle("issue_verification_code req/ip", limit: 5, period: 1.minute) do |req|
        req.ip if (req.patch? || req.put?) && req.path == "/teacher_training_adviser/sign_up/identity"
      end

      # Throttle requests that resend a verification code by IP (5rpm)
      throttle("resend_verification_code req/ip", limit: 5, period: 1.minute) do |req|
        path_resends_verification_code = %r{/*./resend_verification}.match?(req.path)

        req.ip if req.get? && path_resends_verification_code
      end

      # Throttle teacher training adviser sign ups by IP (5rpm)
      throttle("teacher_training_adviser_sign_up req/ip", limit: 5, period: 1.minute) do |req|
        req.ip if (req.patch? || req.put?) && req.path == "/teacher_training_adviser/sign_up/accept_privacy_policy"
      end
    end

    if ENV["FAIL2BAN"].to_s.match? %r{\A\d+\z}
      FAIL2BAN_TIME = ENV["FAIL2BAN"].to_s.to_i.minutes.freeze

      blocklist("block hostile bots") do |req|
        Fail2Ban.filter("hostile-bots-#{req.ip}", maxretry: 0, findtime: 1.second, bantime: FAIL2BAN_TIME) do
          (
            FAIL2BAN_REGEX.match?(CGI.unescape(req.query_string)) ||
            FAIL2BAN_REGEX.match?(req.path)
          ).tap do |should_ban|
            if should_ban
              obscured_ip = req.ip.to_s.gsub(%r{\.\d+\.(\d+)\.}, ".***.***.")

              Rails.logger.info(
                <<~BAN_MESSAGE,
                  Banning IP: #{obscured_ip} for #{FAIL2BAN_TIME.to_i / 60} minutes
                  accessing #{req.path} with '#{req.query_string}'
                BAN_MESSAGE
              )
            end
          end
        end
      end
    end
  end

  Rack::Attack.throttled_response = lambda do |env|
    accept_html = env["HTTP_ACCEPT"].include?("text/html")
    return [429, {}, ["Rate limit exceeded"]] unless accept_html

    html = ApplicationController.render(
      template: "errors/too_many_requests",
      layout: "application",
    )

    [429, { "Content-Type" => "text/html; charset=utf-8" }, [html]]
  end
end
