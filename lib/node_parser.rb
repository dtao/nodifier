require File.dirname(__FILE__) + '/node'

class NodeParser
  def parse(text)
    Node.new text
  end
end