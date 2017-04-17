module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      @names_list = {}
      names.each do |name|
        var_name = "@#{name}".to_sym
        define_method(name) { instance_variable_get(var_name) }

        define_method("#{name}=".to_sym) do |value|
          instance_variable_set(var_name, value)
          (@names_list[name.to_sym] ||= []) << value
        end

      define_method("#{name}_history") { @names_list[name.to_sym] }
    end


    def strong_attr_acessor(name, arg_class)
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}=".to_sym) do |value|
        raise "Type error!" unless value.class == arg_class
        instance_variable_set(var_name, value)
      end
    end
  end
end