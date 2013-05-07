def oauth_client
  @client ||= OAuth2::Client.new(
    ENV['GOOGLE_CLIENT_ID'],
    ENV['GOOGLE_CLIENT_SECRET'],
    :site => 'https://accounts.google.com',
    :token_url => '/o/oauth2/token',
    :authorize_url => '/o/oauth2/auth'
  )
end

def request_token
  if not session[:request_token]
  session[:request_token] = oauth_client.get_request_token(:oauth_callback => "http://localhost:9393/auth")
  end
session[:request_token]
end
