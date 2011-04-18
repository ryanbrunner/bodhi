require 'rails/generators/base'

class BodhiGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      m.template 'bodhi.rb', 'config/initializers/bodhi.rb'
      m.migration_template '001_create_metric_values.rb', 'db/migrate', :migration_file_name => 'create_metric_values'
    end
  end
end