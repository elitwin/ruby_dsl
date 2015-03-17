require_relative 'module_helper'

module Options
  def has_options(name)
    method_module = ModuleHelper.module_for('HasOptions', name, self)
    # using #{whom} in interpolated code will fail because it is not defined
    # at time of method generation
    #line_no = __LINE__; method_defs = %{
    #  def #{name}_for(whom)
    #    find_elements(css: ".gifts-for-#{whom}")
    #  end
    #}

    # Here, the array is called when method is called
    # Another option is to escape the generated characters (second line)
    line_no = __LINE__; method_defs = %{
      def #{name}_for(whom)
        css_locator = [".gifts-for-", whom].join
        find_elements(css: css_locator)
        # find_elements(css: ".gifts-for-\#\{whom\}")
      end
    }
    method_module.module_eval method_defs, __FILE__, line_no
  end
end

class Page
  extend Options

  has_options(:gifts)
end

puts "Methods: #{Page.instance_methods.sort}"
puts "Ancestors: #{Page.ancestors}"
