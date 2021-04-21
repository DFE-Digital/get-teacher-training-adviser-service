module SpecHelpers
  module BasicAuth
    def basic_auth_headers(username, password)
      value = ActionController::HttpAuthentication::Basic.encode_credentials(username, password)
      { "HTTP_AUTHORIZATION" => value }
    end
  end
end
