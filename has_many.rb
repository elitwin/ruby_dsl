module ModuleHelper
  module_function
  def module_for(prefix, name, klass)
    mod_name = prefix + name.to_s.split('_').map(&:capitalize).join
    begin
      method_module = klass.send(:const_get, mod_name)
    rescue NameError
      method_module = Module.new
      klass.send(:const_set, mod_name, method_module)
      # adds as instance methods in the class
      klass.send(:include, method_module)
    end
  end
end

module HasMany
  def has_many(name)
    method_module = ModuleHelper.module_for('HasMany', name, self)

    # Lambda method for compiling code to get better syntax errors
    compile = ->(code, line_no){
      begin
        method_module.module_eval(code, __FILE__, line_no)
      rescue SyntaxError
        raise(SyntaxError, "\n#{ code }\n")
      end
    }

    # evaluate the string and turn it into real Ruby methods
    line_no = __LINE__; code = <<-CODE
      def #{name}
        driver.find_elements(:css, '.#{name}')
      end
    CODE
    compile[code, line_no] #compile.call(code, line_no) - alternate syntax

    line_no = __LINE__; code = <<-CODE
      def #{name}_texts
        #{name}.map(&:text)
      end
    CODE
    compile[code, line_no]
  end
end

class Page
  extend HasMany

  has_many :features
end

puts "Methods: #{Page.instance_methods.sort}"
puts "Ancestors: #{Page.ancestors}"
#puts Page.new.features_texts
