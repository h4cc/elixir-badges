defmodule ElixirBadges.HexClient do
  use HTTPotion.Base

  @user_agent "elixir-badges.herokuapp.com"

  # This is a client for requesting the hex.pm API.

  def process_url(url) do
    "https://hex.pm/api/packages/" <> url
  end

  def process_request_headers(headers) do
    # Let them know, who is asking.
    Dict.put headers, :"User-Agent", @user_agent
  end

  def process_response_body(body) do
    body |> to_string |> Poison.decode!
  end

  # Public interface
  def fetch_package_info(package_name) do
    body = get(package_name).body
    # Formatting to a model here.
    ElixirBadges.Models.HexPackage.create_from_hex(body)
  end
end
