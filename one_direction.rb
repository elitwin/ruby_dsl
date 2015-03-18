module Direction
  def command(options)
    Direction.define_methods(self, options) do |command, accessor|
      %{
      def #{command}(*args, &block)
        #{accessor}.__send__(:#{command}, *args, &block)
        self
      end
      }
    end
  end

  # Forward messages and return the result of the forwarded message
  def query(options)
    Direction.define_methods(self, options) do |query, accessor|
      %{
      def #{query}(*args, &block)
        #{accessor}.__send__(:#{query}, *args, &block)
      end
      }
    end
  end

  def self.define_methods(mod, options)
    method_defs = []
    options.each_pair do |method_names, accessor|
      Array(method_names).map do |message|
        method_defs.push yield(message, accessor)
      end
    end
    mod.class_eval method_defs.join("\n"), __FILE__, __LINE__
  end
end

class One
  extend Direction
  command [:something, :otherthing] => :two

  attr_accessor :two
end

class Two
  def something
    puts 'I shot the sheriff'
  end

  def otherthing
    puts 'But I didn\'t shoot no deputy'
  end
end

one = One.new
one.two = Two.new
one.something
one.otherthing
