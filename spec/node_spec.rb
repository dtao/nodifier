require File.dirname(__FILE__) + '/../lib/node'
require File.dirname(__FILE__) + '/../lib/nodifier'
require File.dirname(__FILE__) + '/matchers'

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
        @node.to_s.should be_like_block <<-EOS
          foo
            bar
            buzz
        EOS
      end

      it 'works for any arbitrary amount of nesting' do
        nodes = Nodifier.new.nodify <<-EOS
          foo
           bar
            buzz
             a
              b
               c
        EOS

        nodes.to_s.should be_like_block <<-EOS
          foo
            bar
              buzz
                a
                  b
                    c
        EOS
      end

      it 'accepts a formatter block with which to format each node' do
        @node.to_s { |node| 'blah' }.should be_like_block <<-EOS
          blah
            blah
            blah
        EOS
      end

      it 'allows the formatter block to prevent further formatting of the children of a node (in case the formatter already handled that)' do
        @node.to_s { |node, state| state.children_are_formatted!; 'blah' }.should == 'blah'
      end

      it 'passes the node itself (not an array) to the formatter block if the block takes one parameter' do
        @node.to_s { |node| node.is_a?(Node).to_s }.should be_like_block <<-EOS
          true
            true
            true
        EOS
      end

      it 'works for a mixture of formatters' do
        nodes = Nodifier.new.nodify <<-EOS
          foo
            bar
          xml
            foo
              bar
          foo
            bar
        EOS

        output = nodes.to_s do |node, state|
          if node.label == 'xml'
            state.children_are_formatted!
            node.to_xml
          else
            node.label
          end
        end

        output.should be_like_block <<-EOS
          foo
            bar
          <xml>
            <foo>
              <bar />
            </foo>
          </xml>
          foo
            bar
        EOS
      end
    end
  end

  describe '#to_json' do
    it 'renders the node the same as JsonNodeFormatter' do
      node = Node.new 'foo'
      node.children << Node.new('bar')
      node.children << Node.new('buzz')

      node.to_json.should be_like_block <<-EOS
        {
          "foo": {
            "bar": null,
            "buzz": null
          }
        }
      EOS
    end
  end
  
  describe '#to_xml' do
    it 'renders the node the same as XmlNodeFormatter' do
      node = Node.new 'foo'
      node.children << Node.new('bar')
      node.children << Node.new('buzz')

      node.to_xml.should be_like_block <<-EOS
        <foo>
          <bar />
          <buzz />
        </foo>
      EOS
    end
  end

end