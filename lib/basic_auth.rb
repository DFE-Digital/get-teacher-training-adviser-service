class BasicAuth
  class << self
    def authenticate(username, password)
      return false unless [username, password].all?(&:present?)

      credentials.any? { |c| c[:username] == username && c[:password] == password }
    end

    def credentials
      @@credentials ||= http_auth.split(",").map do |credential|
        parts = credential.split("=")
        { username: parts.first, password: parts.last }
      end
    end

    def http_auth
      Rails.application.credentials.config[:http_auth] || ""
    end

    def env_requires_auth?
      basic_auth = Rails.application.config.x.basic_auth

      return false if basic_auth.blank?

      ActiveModel::Type::Boolean.new.cast(basic_auth)
    end
  end
end
