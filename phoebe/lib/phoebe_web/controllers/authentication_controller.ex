defmodule PhoebeWeb.AuthenticationController do
  use Phoenix.Controller
  import Joken
  import Plug.Conn

  def authenticate(conn, _params) do
    jwt_secret = Application.fetch_env!(:phoebe, :jwt_secret)
    token = Phoenix.Token.sign(conn, "jwt_secret", jwt_secret)
    authenticated = check_authentication(conn, _params)
  end

  defp check_authentication(conn, _params) do
    token = get_token_from_request(conn)

    jwt_secret = Application.fetch_env!(:phoebe, :jwt_secret)

    signer = Joken.Signer.create("HS256", jwt_secret)

    case Phoebe.Auth.Token.verify_and_validate(token, signer) do
      {:ok, %{"email" => email, "name" => name}} ->
        IO.puts "received: #{name} #{email}"
        json(conn, %{authenticated: true})

      {:error, {test}} ->
        IO.puts(test)
        json(conn, %{authenticated: false})
    end
  end

  defp get_token_from_request(conn) do
    case Plug.Conn.get_req_header(conn, "authorization") do
      [header_value | _] ->
        [_, token] = String.split(header_value, "Bearer ")
        token

      _ ->
        nil
    end
  end
end
