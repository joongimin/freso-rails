module Nuvo
  class API
    def client
      OAuth2::Client.new(Settings.nuvo_app_id, Settings.nuvo_secret, :site => Settings.nuvo_site, :authorize_path => Settings.nuvo_authorize_path)
    end

    def initialize(access_token)
      @access_token = OAuth2::AccessToken.from_hash(client, :access_token => access_token)
    end

    def hubs
      @access_token.get("api/hubs.json").parsed
    end
  end
end