defmodule PhoebeWeb.AuthenticationController do
  use Phoenix.Controller

  def authenticate(conn, _params) do
    jwt_secret = Application.fetch_env!(:phoebe, :jwt_secret)
    IO.puts("jwt_secret")
    IO.inspect(jwt_secret)
    token = Phoenix.Token.sign(conn, "jwt_secret", jwt_secret)
    authenticated = check_authentication(conn)

    json(conn, %{authenticated: authenticated})
  end

  defp check_authentication(conn) do
    # figure this out
    true
  end

  defp get_token_from_request(conn) do
    case get_req_header(conn, "authorization") do
      [header_value | _] ->
        String.split(header_value, "Bearer ")[-1]

      _ ->
        nil
    end
  end

  # defp check_authentication(conn) do
  #   case validate_token(conn) do
  #     {:ok, _claims} ->
  #       # Token is valid, return 200 OK
  #       send_resp(conn, 200, "Token is valid")

  #     {:error, reason} ->
  #       # Token is invalid, return 401 Unauthorized
  #       send_resp(conn, 401, "Token is invalid")
  #   end
  # end

  # defp validate_token(conn) do
  #   # Retrieve the JWT token from the request headers or other source
  #   token = get_token_from_request(conn)

  #   case Guardian.decode_and_verify(token) do
  #     {:ok, claims} ->
  #       {:ok, claims}

  #     {:error, _reason} ->
  #       {:error, "Invalid token"}
  #   end
  # end

  # defp get_token_from_request(conn) do
  #   # Retrieve the JWT token from the request headers or other source
  #   # Example: If the token is passed in the "Authorization" header as "Bearer <token>"
  #   case get_req_header(conn, "authorization") do
  #     [header_value | _] ->
  #       String.split(header_value, "Bearer ")[-1]

  #     _ ->
  #       nil
  #   end
  # end
end
