require 'spec_helper'

module Bodhi
  describe Metric do
    it "accepts a block and and a name" do
      m = Metric.define :my_metric do |run|
        1
      end

      m.name.should == :my_metric
      m.current.should == 1
    end

    it "can preload a model into a run" do
      m = Metric.define :my_model_metric, :model_name => :dog do |run|
        run[:model].count
      end

      m.current.should == 3 # defined in mock_model.rb
    end

  end
end