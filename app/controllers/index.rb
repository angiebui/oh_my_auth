get '/' do
  oauth_client

  erb :index
end

get '/sign_in' do

  redirect oauth_client.auth_code.authorize_url(
    :redirect_uri => "http://localhost:9393/oauth2callback",
    :scope => "https://www.googleapis.com/auth/userinfo.profile"
    )
end

get '/oauth2callback' do
  token = oauth_client.auth_code.get_token(
    params[:code],
    :redirect_uri => "http://localhost:9393/oauth2callback"
    )

  response = token.get 'https://www.googleapis.com/oauth2/v1/userinfo?alt=json'
  user_info = JSON.parse(response.body)

  User.create(:access_token => params[:code], :google_id => user_info["id"], :name => user_info["name"], :picture => user_info["picture"])
  # storing access_token, google id and etc

  redirect to('/')
end 
