module HasMany
  def has_many(name)
    name_to_module = name.to_s.split('_').map(&:capitalize).join
    mod_name = 'HasMany' + name_to_module
    begin
      method_module = self.const_get(mod_name)
    rescue NameError
      method_module = Module.new
      self.const_set(mod_name, method_module)
      # adds as instance methods in the class
      include method_module
    end

    # include line_no on same line as method_defs to provide
    # correct location of any errors in the stack trace
    line_no = __LINE__; method_defs = %{
      def #{name}
        driver.find_elements(:css, '.#{name}')
      end

      def #{name}_texts
        #{name}.map(&:text)
      end
    }
    # evaluate the string and turn it into real Ruby methods
    method_module.module_eval method_defs, __FILE__, line_no
  end
end

class Page
  extend HasMany

  has_many :features
end

puts "Methods: #{Page.instance_methods.sort}"
puts "Ancestors: #{Page.ancestors}"
#puts Page.new.features_texts
