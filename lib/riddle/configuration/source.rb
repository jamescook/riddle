module Riddle
  class Configuration
    class Source < Riddle::Configuration::Section
      self.settings = [:type]
      
      attr_accessor :name, :parent, :type
      
      def initialize(name, type)
        @name = name
        @type = type
      end
      
      def render
        raise ConfigurationError unless valid?
        
        inherited_name = "#{name}"
        inherited_name << " : #{parent}" if parent
        (
          ["source #{inherited_name}", "{"] +
          settings_body +
          ["}", ""]
        ).join("\n")
      end
      
      def valid?
        !( @name.nil? || @type.nil? )
      end
    end
  end
end