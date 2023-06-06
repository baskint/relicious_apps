# Relicious Apps
This is a dual application configuration where we use a JWT with a shared key to authenticate between the apps. The JWT has the following sample payload:
```
{ email: "John Doe", email: "john@example.com" }
```

## Rayols
Payload sending app - this is a Rails 7 application using Ruby 3.2.2.
First, `cd royals`, then using `rbenv`, we can configure the runtime environment for this as follows:

1. `rbenv install 3.2.2`
2. `gem install rails --version 7.0.0`
3. `bundle install`

Also create a `.env` file inside the `rayols` directory and add the below contents:
`RAYOLS_JWT_SECRET="testing123"`

After this, start the `rails server` at default port 3000.

## Phoebe
Payload receiving app - this is Phoenix 1.7.3 application using Erlang 26.0 and  Elixir 1.14.5. First `cd phoebe`. Then using `asdf`, we can configure the runtime environment as follows:

1. `asdf install erlang 26.0`
2. `asdf install elixir 1.14.5`
3. `asdf local erlang 26.0`
4. `asdf local elixir 1.14.5`
5. `mix local.hex`
6. `mix archive.install hex phx_new`
7. `mix deps.get`
8. `iex -S mix phx.server`

This will start the API application port 4000. The JWT secret is contained in `dev.secret.exs` file (ideally this file should not be checked into a repo, but it is here for demo purposes).

Once both apps are up running without issues, visit on a browser
`http://localhost:3000` and click on `Authenticate` button.

Then go back to terminal on the Phoenix app, verify the payload is received successfully. Mismatch the signatures and verify that it fails. 

```
iex(1)> [info] GET /api/authenticate
[debug] Processing with PhoebeWeb.AuthenticationController.authenticate/2
  Parameters: %{}
  Pipelines: [:api]
received: John Doe john@example.com
[info] Sent 200 in 83ms
```

Let me know if you have areas for improvement. Thanks for checking it out.

Baskin Tapkan - June, 2023.
