require File.dirname(__FILE__) + '/../lib/node'
require File.dirname(__FILE__) + '/../lib/nodifier'

describe Node do

  describe '#to_s' do
    context 'node without children' do
      before :each do
        @node = Node.new 'foo'
      end

      it 'returns the label of the node' do
        @node.to_s.should == 'foo'
      end
    end

    context 'node with children' do
      before :each do
        @node = Node.new 'foo'
        @node.children << Node.new('bar')
        @node.children << Node.new('buzz')
      end

      it 'returns an indented list comprising the label of the node and those of its children' do
        @node.to_s.should == "foo\n  bar\n  buzz"
      end

      it 'works for any arbitrary amount of nesting' do
        @node = Nodifier.new.nodify <<-EOS
          foo
           bar
            buzz
             a
              b
               c
        EOS

        @node.to_s.should == "foo\n  bar\n    buzz\n      a\n        b\n          c"
      end

      it 'accepts a formatter block with which to format each node' do
        @node.to_s { |node| 'blah' }.should == "blah\n  blah\n  blah"
      end

      it 'allows the formatter block to prevent further formatting of the children of a node (in case the formatter already handled that)' do
        @node.to_s { |node, stopper| stopper.stop!; 'blah' }.should == 'blah'
      end

      it 'passes the node itself (not an array) to the formatter block if the block takes one parameter' do
        @node.to_s { |node| node.is_a?(Node).to_s }.should == "true\n  true\n  true"
      end
    end
  end
  
  describe '#to_xml' do
    it 'renders the node the same as XmlNodeFormatter' do
      node = Node.new 'foo'
      node.children << Node.new('bar')
      node.children << Node.new('buzz')

      node.to_xml.should == "<foo>\n  <bar />\n  <buzz />\n</foo>"
    end
  end

end