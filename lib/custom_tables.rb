require "active_support"
require 'byebug'


require "custom_tables/version"
require "custom_tables/controllers/class_methods"
require "custom_tables/models/class_methods"



module CustomTables
end

ActionController::Base.send(:include, CustomTables::Controllers)
ActiveRecord::Base.send(:include, CustomTables::Models)