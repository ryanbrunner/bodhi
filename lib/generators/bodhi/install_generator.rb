require 'rails/generators/base'
require 'rails/generators/migration'
require 'rails/generators/active_record'

module Bodhi
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      desc "Setup migrations and initializer for bodhi"
      source_root File.expand_path("../templates", __FILE__)

      def self.next_migration_number (dirname)
        ActiveRecord::Generators::Base.next_migration_number (dirname)
      end

      def copy_files
        copy_file 'bodhi.rb', 'config/initializers/bodhi.rb'
        migration_template 'create_metric_values.rb', 
          "db/migrate/create_metric_values.rb"
      end
    end
  end
end