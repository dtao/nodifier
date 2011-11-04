Introduction
============

**Nodifier** is intended as a very simple library to parse plain text into a node-based structure.

The basic idea behind **Nodifier** is that it can be used to devise a system of storing domain-specific information in a textual format that is as _concise_ and _human-readable_ as possible.

Basics
======

At the heart of **Nodifier** is the `Node` class, which comprises a `label` (String) and `children` (Array):

```ruby
node = Node.new 'foo'

# Outputs 'foo: 0 children'
puts "#{node.label}: #{node.children.size} children"
```

A collection of `Node` objects is created using the `Nodifier` class:

```ruby
nodifier = Nodifier.new

content = <<-EOS
  foo
    bar
    buzz
EOS

nodes = nodifier.nodify content
```

This collection can then be formatted as, e.g., XML:

```ruby
puts nodes.to_xml
```

Output:

```xml
<foo>
  <bar />
  <buzz />
</foo>
```

You can also nodify key/value pairs using the same method:

```ruby
nodifier = Nodifier.new

content = <<-EOS
  foo
    bar: bar_value
    buzz: buzz_value
EOS

nodes = nodifier.nodify content
```

Formatting as JSON is also an option:

```ruby
puts nodes.to_json
```

Output:

```json
{
  "foo": {
    "bar": "bar_value",
    "buzz": "buzz_value"
  }
}
```

Advanced
========

Where **Nodifier** is really meant to shine (not claiming it *actually* shines in this regard yet) is in facilitating the development of *custom* domain-specific formats for capturing the data used on a particular project or by a particular organization concisely. For this purpose, the `Nodifier` class can be initialized with a custom parser, which can in turn create custom `Node` objects.

[Example to come]