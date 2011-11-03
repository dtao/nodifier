require File.dirname(__FILE__) + '/indentation'
require File.dirname(__FILE__) + '/node'

class XmlNodeFormatter
  include Indentation

  def format(node, indent_level = 0)
    return indent("<#{node.label} />", indent_level) if node.children.empty?

    xml = indent("<#{node.label}>", indent_level)

    node.children.each do |child|
      xml << "\n"
      xml << format(child, indent_level + 1)
    end

    xml << "\n"
    xml << indent("</#{node.label}>", indent_level)

    xml
  end
end