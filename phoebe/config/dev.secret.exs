import Config

config :phoebe, :jwt_secret, System.get_env("PHOEBE_JWT_SECRET")
