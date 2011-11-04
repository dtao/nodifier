require File.dirname(__FILE__) + '/../lib/node'
require File.dirname(__FILE__) + '/matchers'

describe JsonNodeFormatter do

  before :each do
    @formatter = JsonNodeFormatter.new
  end

  describe '#format' do
    before :each do
      @nodes = Nodes.new

      @first_node = Node.new 'foo'
      @first_node.children << Node.new('bar: x')
      @first_node.children << Node.new('buzz: y')

      @second_node = Node.new 'a'
      @second_node.children << Node.new('b: m')
      @second_node.children << Node.new('c: n')

      @nodes << @first_node
      @nodes << @second_node
    end

    it 'creates a JSON document with keys and values specified by node labels' do
      @formatter.format(@nodes).should be_like_block <<-EOS
        {
          "foo": {
            "bar": "x",
            "buzz": "y"
          },
          "a": {
            "b": "m",
            "c": "n"
          }
        }
      EOS
    end

    it 'works for individual nodes just as well as node arrays' do
      @formatter.format(@first_node).should be_like_block <<-EOS
        {
          "foo": {
            "bar": "x",
            "buzz": "y"
          }
        }
      EOS
    end
  end

end