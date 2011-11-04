require File.dirname(__FILE__) + '/indentation'
require File.dirname(__FILE__) + '/node'

class XmlNodeFormatter
  include Indentation

  def format(nodes, indent_level = 0)
    if nodes.is_a?(Node)
      return format_single_node(nodes, indent_level)
    end

    nodes.map { |node|
      format_single_node(node, indent_level)
    }.join("\n")
  end

  private
  def format_single_node(node, indent_level = 0)
    return indent("<#{node.label} />", indent_level) if node.children.empty?

    xml = indent("<#{node.label}>", indent_level)

    node.children.each do |child|
      xml << "\n"
      xml << format_single_node(child, indent_level + 1)
    end

    xml << "\n"
    xml << indent("</#{node.label}>", indent_level)

    xml
  end
end