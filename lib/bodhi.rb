require 'bodhi/definitions/count'
require 'bodhi/definitions/aggregate'
require 'bodhi/storage/metric_value'
require 'bodhi/metric'
require 'bodhi/helpers/bodhi_helpers'

module Bodhi
  ActionView::Base.send :include, Bodhi::Helpers if defined?(ActionView::Base)  
end

