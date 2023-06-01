defmodule PhoebeWeb.AuthenticationController do
  use Phoenix.Controller

  def authenticate(conn, _params) do
    jwt_secret = Application.fetch_env!(:phoebe, :jwt_secret)
    token = Phoenix.Token.sign(conn, "jwt_secret", jwt_secret)
    authenticated = check_authentication(token)
    json(conn, %{ authenticated: authenticated })
  end

  defp check_authentication(token) do
    # Perform your JWT decoding and authentication logic here
    # Compare the received token with the shared secret
  end
end