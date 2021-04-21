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
  end
end
