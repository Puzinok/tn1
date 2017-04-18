module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        define_method(name) { instance_variable_get(var_name) }

        define_method("#{name}=".to_sym) do |value|
          instance_variable_set(var_name, value)
          @names_list ||= {}
          (@names_list[var_name] ||= []) << value
        end

        define_method("#{name}_history") { @names_list[var_name] }
      end
    end

    def strong_attr_accessor(name, arg_class)
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}=".to_sym) do |value|
        raise 'Неверный тип, ожидается  #{arg_class}!' unless value.is_a?(arg_class)
        instance_variable_set(var_name, value)
      end
    end
  end
end
