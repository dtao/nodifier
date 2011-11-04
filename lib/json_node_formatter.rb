require File.dirname(__FILE__) + '/indentation'

class JsonNodeFormatter
  include Indentation

  def format(nodes)
    if nodes.is_a?(Node)
      return "{\n#{format_single_node(nodes, 1)}\n}"
    end

    json = nodes.map { |node|
      format_single_node(node, 1)
    }.join(",\n")

    "{\n#{json}\n}"
  end

  private
  def format_single_node(node, indent_level = 0)
    key, value = node.label.split(/:\s*/)

    return indent("\"#{key}\": \"#{value || 'null'}\"", indent_level) if node.children.empty?

    json = indent("\"#{key}\": {", indent_level)

    first_child = true
    node.children.each do |child|
      json << "," if not first_child
      json << "\n"
      json << format_single_node(child, indent_level + 1)
      first_child = false
    end

    json << "\n"
    json << indent("}", indent_level)

    json
  end
end