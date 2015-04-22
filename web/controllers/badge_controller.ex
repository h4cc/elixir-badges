defmodule ElixirBadges.BadgeController do
  use ElixirBadges.Web, :controller

  @font_size 14
  @width_per_char 9.4

  plug :action

  def licenses(conn, %{"name" => name}) do
    package = Hex.get_package(name)
    conn
      |> put_resp_content_type("image/svg+xml")
      |> send_resp(200, licenses_badge(package.licenses))
  end

  # Helper to generate the SVG content for a list of licenses
  defp licenses_badge(licenses) when is_list licenses do
    content = Enum.join(licenses, ", ")

    width_s = to_string(width = String.length(content) * @width_per_char)
    height_s = to_string(height = 20)
    "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"" <> width_s <> "\" height=\"" <> height_s <> "\">
      <g fill=\"#000\" text-anchor=\"middle\" font-family=\"DejaVu Sans,Verdana,Geneva,sans-serif\" font-size=\"" <> to_string(@font_size) <> "\">
        <text x=\"" <> to_string(width / 2 + 1) <> "\" y=\"14\">"<>content<>"</text>
      </g>
    </svg>"
  end
end
