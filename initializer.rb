module CustomInitializer
  def initialize(*setup_args)
    attr_reader(*setup_args)
    private(*setup_args)

    method_module = Module.new
    line = __LINE__; method_module.class_eval %{
      def initialize(#{setup_args.join(',')})
        #{setup_args.map do |arg|
          ['@',arg,' = ',arg].join
        end.join("\n")}
      end
    }, __FILE__, line
    const_set('Initializer', method_module)
    include method_module
  end
end

class Employment
  extend CustomInitializer

  initialize :boss, :employee
end

puts "Methods: #{Employment.instance_methods.sort}"
puts "Private Methods: #{Employment.private_methods.sort}"
puts "Ancestors: #{Employment.ancestors}"
puts "Employement: #{Employment.new('John Boss', 'Joe Employee').inspect}"
