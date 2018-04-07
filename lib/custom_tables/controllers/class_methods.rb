module CustomTables
  module Controllers
    extend ActiveSupport::Concern
    
    module ClassMethods

      def has_custom_index(config={})
        send(:include, InstanceMethods)
        @index_headers = config[:default_headers]
        before_action :set_default_headers, :only => [:index] + config.fetch(:additional_before_actions, [])
        @default_headers = config.fetch(:default_headers, [])
        @translation_base = config.fetch(:translation_base, nil)
      end

      def default_headers
        @default_headers
      end

      def translation_base
        @translation_base
      end

      module InstanceMethods
        def set_default_headers
          resource_class = params[:controller].classify.underscore
          @default_headers = self.class.default_headers
          @translation_base = self.class.translation_base || resource_class
        end
      end

    end
  end
end