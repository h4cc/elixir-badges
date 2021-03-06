defmodule ElixirBadges.Endpoint do
  use Phoenix.Endpoint, otp_app: :elixir_badges

  # Serve at "/" the given assets from "priv/static" directory
  plug Plug.Static,
    at: "/", from: :elixir_badges,
    only: ~w(css images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.Logger

  # Skipp all the not needed parsers.
  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart], #, :json
    pass: ["*/*"]
  #  json_decoder: Poison

  #plug Plug.MethodOverride
  #plug Plug.Head

  #plug Plug.Session,
  #  store: :cookie,
  #  key: "_elixir_badges_key",
  #  signing_salt: "qYApdCKY",
  #  encryption_salt: "z5gqyiH9"

  plug :router, ElixirBadges.Router
end
