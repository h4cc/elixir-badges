defmodule ElixirBadges.Mixfile do
  use Mix.Project

  def project do
    [app: :elixir_badges,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {ElixirBadges, []},
     applications: [:phoenix, :cowboy, :logger, :ecto, :httpotion]]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [
     {:phoenix, "~> 0.11"},
     {:phoenix_ecto, "~> 0.3"},
     {:postgrex, ">= 0.0.0"},
     {:phoenix_live_reload, "~> 0.3"},
     {:cowboy, "~> 1.0"},
     {:ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.1.1"},
     {:httpotion, "~> 2.0"},
     {:poison, "~> 1.4"}
    ]
  end
end
