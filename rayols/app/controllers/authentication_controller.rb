class AuthenticationController < ApplicationController
  def authenticate
    name = 'John Doe' # Replace with the user's name
    email = 'john@example.com' # Replace with the user's email
    authenticated = AuthenticationService.authenticate_user(name, email)

    if authenticated
      flash[:success] = 'Authentication successful!'
    else
      flash[:error] = 'Authentication failed!'
    end

    redirect_to root_path
  end
end
