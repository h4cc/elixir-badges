defmodule ElixirBadges.Hex do

  alias ElixirBadges.Cache
  alias ElixirBadges.HexClient

  # This Module is a facade to all the stuff for fetching
  # information from hex and caching them.

  @cache_timeout_seconds 3600

  def get_package(name) do
    name = String.to_atom(name)
    case Cache.get(name) do
      {:value, value} ->
            value
      :notfound ->
        fetch(name) |> cache(name)
      {:value_timeout, stale_value} ->
        try_fetch_cache(name, stale_value)
    end
  end

  defp fetch(name) do
    HexClient.fetch_package_info(name)
  end

  defp try_fetch_cache(name, default) do
    try do
      fetch(name) |> cache(name)
    rescue
      _e in HTTPotion.HTTPError -> default
    end
  end

  defp cache(value, key) do
    Cache.set(key, value, @cache_timeout_seconds)
    value
  end

end