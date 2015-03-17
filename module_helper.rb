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
