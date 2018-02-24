require 'action_view/helpers'
require 'action_view/context'
module CustomTables
  module ActionView
    module Helpers
      def render_custom_table(resources)
        content_for(:custom_table) do
          render :partial => 'custom_tables/custom_table', locals: { resources: resources  }
        end
      end
    end
  end
end
