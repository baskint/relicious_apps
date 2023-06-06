require 'httparty'

class AuthenticationService
  include HTTParty
  base_uri 'http://localhost:4000' # Replace with the URL of your Phoenix app

  def self.authenticate_user(name, email)
    jwt_token = JWT.encode({ name: name, email: email }, ENV['RAYOLS_JWT_SECRET'], 'HS256')

    headers = { 'Authorization' => "Bearer #{jwt_token}" }
    response = get('/api/authenticate', headers: headers)
    response.parsed_response['authenticated']
  end
end
