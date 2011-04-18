require 'rubygems'
require 'bundler/setup'
require 'bodhi'
require 'active_record'

require 'support/mock_model'

RSpec.configure do |config|
  config.mock_with :rspec
end
