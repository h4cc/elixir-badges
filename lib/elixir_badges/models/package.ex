defmodule ElixirBadges.Models.HexPackage do

  defstruct name: "", licenses: []

  alias ElixirBadges.Models.HexPackage

  def create_from_hex(map) do
    %HexPackage{
      name: map["name"],
      licenses: map["meta"]["licenses"]
    }
  end

end