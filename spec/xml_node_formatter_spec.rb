require File.dirname(__FILE__) + '/../lib/node'
require File.dirname(__FILE__) + '/matchers'

describe XmlNodeFormatter do

  include Indentation

  before :each do
    @formatter = XmlNodeFormatter.new
  end

  describe '#format' do
    before :each do
      @nodes = Nodes.new

      @first_node = Node.new 'foo'
      @first_node.children << Node.new('bar')
      @first_node.children << Node.new('buzz')

      @second_node = Node.new 'a'
      @second_node.children << Node.new('b')
      @second_node.children << Node.new('c')

      @nodes << @first_node
      @nodes << @second_node
    end

    it 'creates an XML document with elements whose tags are the labels of the given node structure' do
      @formatter.format(@nodes).should be_like_block <<-EOS
        <foo>
          <bar />
          <buzz />
        </foo>
        <a>
          <b />
          <c />
        </a>
      EOS
    end

    it 'works for individual nodes just as well as node arrays' do
      @formatter.format(@first_node).should be_like_block <<-EOS
        <foo>
          <bar />
          <buzz />
        </foo>
      EOS
    end
  end

end