require "kemal"
require "./recolor/*"

get "/" do
  xml = %{<svg fill="black">
    <path stroke="blue">
      <circle fill="#808080"/>
    </path>
  </svg>}
  SvgColorizer.new(xml).colorize_as_data("green")
end

Kemal.run
