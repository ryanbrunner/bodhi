# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "bodhi/version"

Gem::Specification.new do |s|
  s.name        = "bodhi"
  s.version     = Bodhi::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ryan Brunner"]
  s.email       = ["ryan@ryanbrunner.com"]
  s.homepage    = ""
  s.summary     = %q{A simple, flexible DSL for generating reports.}
  s.description = %q{}

  s.rubyforge_project = "bodhi"

  s.add_development_dependency "rspec"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'activesupport'
  s.add_development_dependency 'i18n'
  s.add_development_dependency 'activerecord'


  s.files = [
     "Gemfile",
     "Gemfile.lock",
     "README.markdown",
     "Rakefile",
     "bodhi.gemspec",
     "lib/generators/bodhi/install_generator.rb",
     "lib/generators/bodhi/templates/bodhi.rb",
     "lib/generators/bodhi/templates/create_metric_values.rb",
     "lib/bodhi.rb",
     "lib/bodhi/metric.rb",
     "lib/bodhi/version.rb",
     "lib/bodhi/definitions/aggregate.rb",
     "lib/bodhi/definitions/count.rb",
     "lib/bodhi/storage/metric_value.rb",
     "lib/bodhi/helpers/bodhi_helpers.rb",
     "spec/support/mock_model.rb",
     "spec/support/persistence_spec.rb",
     "spec/aggregate_metrics_spec.rb",
     "spec/metric_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.require_paths = ["lib"]
end
