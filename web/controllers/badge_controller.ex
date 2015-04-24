defmodule ElixirBadges.BadgeController do
  use ElixirBadges.Web, :controller

  @font_size 12
  @font_family "DejaVu Sans,Verdana,Geneva,sans-serif"
  @width_per_char 7.4

  plug :action

  def licenses(conn, %{"name" => name}) do
    package = Hex.get_package(name)
    conn
      |> put_resp_content_type("image/svg+xml")
      |> put_resp_header("cache-control", "max-age=60")
      |> send_resp(200, licenses_badge(package.licenses))
  end

  # Helper to generate the SVG content for a list of licenses
  defp licenses_badge(licenses) when is_list licenses do
    content = Enum.join(licenses, ", ")

    width_s = to_string(width = (14 + (String.length(content) * @width_per_char)))

    "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"" <> width_s <> "\" height=\"20\">

      <linearGradient id=\"smooth\" x2=\"0\" y2=\"100%\">
        <stop offset=\"0\" stop-color=\"#bbb\" stop-opacity=\".1\"/>
        <stop offset=\"1\" stop-opacity=\".1\"/>
      </linearGradient>
    
      <mask id=\"round\">
        <rect width=\"" <> width_s <> "\" height=\"20\" rx=\"3\" fill=\"#fff\"/>
      </mask>
    
      <g mask=\"url(#round)\">
        <rect x=\"0\" width=\"" <> width_s <> "\" height=\"20\" fill=\"#ddd\"/>
        <rect width=\"" <> width_s <> "\" height=\"20\" fill=\"url(#smooth)\"/>
      </g>
    
      <g fill=\"#fff\" text-anchor=\"middle\" font-family=\""<>@font_family<>"\" font-size=\"" <> to_string(@font_size) <> "\">
        <text x=\"" <> to_string(width / 2) <> "\" y=\"16\" fill=\"#010101\" fill-opacity=\".3\">"<>content<>"</text>
        <text x=\"" <> to_string(width / 2) <> "\" y=\"15\">"<>content<>"</text>
      </g>
    </svg>"
  end
end
