module CustomTables
  module Models
    extend ActiveSupport::Concern
    
    module ClassMethods
      def has_custom_index
        send(:include, InstanceMethods)
      end
    end

    module InstanceMethods

      def index_display_value_for(property_name)
        if self.respond_to?("index_display_#{property_name}")
          display_value = self.send("index_display_#{property_name}")
        else
          display_value = self.send(property_name)
        end
        display_value
      end

      def html_table_name
        "#{self.class.name.underscore.pluralize}_index_table"
      end

    end
  end
end