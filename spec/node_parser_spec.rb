require File.dirname(__FILE__) + '/../src/node_parser'

describe NodeParser do

  before :each do
    @parser = NodeParser.new
  end

  describe '#parse_node' do

    it 'creates a Node object' do
      @parser.parse('foo').should be_a(Node)
    end

    it 'assigns the given text as the label of the Node' do
      @parser.parse('foo').label.should == 'foo'
    end
    
    it 'adds no children to the Node' do
      @parser.parse('foo').children.should be_empty
    end

  end

end