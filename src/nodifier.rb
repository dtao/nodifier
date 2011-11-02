require File.dirname(__FILE__) + '/indentation'
require File.dirname(__FILE__) + '/node'
require File.dirname(__FILE__) + '/node_parser'

class Nodifier
  include Indentation

  def initialize(parser = nil)
    @parser = parser || NodeParser.new
  end

  def nodify(content)
    nodes = []
    current_node = nil
    child_content = ''

    content = unindent content

    content.lines do |line|
      if not line.start_with?(' ')
        if not child_content.empty?
          append_child_content current_node, child_content
          child_content = ''
        end

        current_node = @parser.parse line.rstrip
        nodes << current_node
      else
        child_content << line
      end
    end

    append_child_content current_node, child_content unless child_content.empty?

    nodes
  end

  def append_child_content(node, child_content)
    nodify(child_content).each do |child_node|
      node.children << child_node
    end
  end
end