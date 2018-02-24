require 'rails/railtie'
module CustomTables
  class Railtie < ::Rails::Railtie
    initializer "custom_tables.action_view" do |app|
      ActiveSupport.on_load :action_view do
        require "custom_tables/action_view/helpers"
        include CustomTables::ActionView::Helpers
      end
    end
  end
end