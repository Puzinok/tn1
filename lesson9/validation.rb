module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send(:include, InstanceMethods)
  end

  module ClassMethods
    def validate(attribute, type_validation, arg = nil)
      @validations ||= {}
      @validations[attribute] ||= []
      @validations[attribute] << [type_validation, arg]
    end
  end

  module InstanceMethods
    def validate!
      self.class.instance_variable_get(:@validations).each do |key, value|
        value.each { |v| send("validate_#{v[0]}", key, *v[1]) }
      end
    rescue RuntimeError => e
      puts "Ошибка! #{e}"
    end

    def valid?
      validate!
    rescue
      false
    end

    private

    def validate_presence(name)
      raise "#{name} = nil, или пустой строке!" if send(name.to_s).to_s.empty?
    end

    def validate_type(name, type)
      raise "#{name} не является классом #{type}!" unless send(name.to_s).is_a?(type)
    end

    def validate_format(name, format)
      raise "#{name} не соответстует #{format}" if send(name.to_s).to_s !~ format
    end
  end
end
