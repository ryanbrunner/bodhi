require 'rails/generators/base'

module Bodhi
  class InstallGenerator < Rails::Generator::Base
    def manifest
      record do |m|
        m.migration_template '001_create_metric_values.rb', 'db/migrate', :migration_file_name => 'create_metric_values'
      end
    end
  end
end