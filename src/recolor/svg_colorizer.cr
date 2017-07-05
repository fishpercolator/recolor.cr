require "xml"

class SvgColorizer
  
  def initialize(data : String)
    @doc = XML.parse(data)
  end
  
  # Output the document colorized with the given hex color
  def colorize(color : String)
    if root = @doc.root
      root["fill"] = color
      root.children.each do |child|
        colorize_node(child, color)
      end
    end
    @doc.to_s
  end
  
  # Colorize and return a data URI
  def colorize_as_data(color : String)
    b64 = Base64.strict_encode(colorize(color))
    "data:image/svg+xml;base64,#{b64}"
  end
  
  private def colorize_node(node : XML::Node, color : String)
    # Handle CSS nodes differently
    if node.name == "style" && node["type"] == "text/css"
      colorize_css(node, color)
      return
    end
    %w{fill stroke}.each do |att|
      if node[att]? && node[att] != "none"
        node.attributes[att].content = color
      end
      node.children.each do |child|
        colorize_node(child, color)
      end
    end
  end
  
  private def colorize_css(node : XML::Node, color : String)
    node.content = node.content.gsub(/(fill|stroke):\s*(.*?);/, "\\1: #{color};")
  end
  
end
