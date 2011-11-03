require File.dirname(__FILE__) + '/../lib/node'

describe XmlNodeFormatter do

  include Indentation

  before :each do
    @formatter = XmlNodeFormatter.new
  end

  describe '#format' do
    before :each do
      @node = Node.new 'foo'
      @node.children << Node.new('bar')
      @node.children << Node.new('buzz')
    end

    it 'creates an XML document with elements whose tags are the labels of the given node structure' do
      expected = <<-EOS
        <foo>
          <bar />
          <buzz />
        </foo>
      EOS

      expected = unindent(expected).strip

      @formatter.format(@node).should == expected
    end
  end

end