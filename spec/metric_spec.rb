require 'spec_helper'

module Bodhi
  describe Metric do
    it "accepts a block and and a name" do
      m = Metric.define :my_metric do |run|
        1
      end

      m.name.should == :my_metric
      m.current[:value].should == 1
    end

    it "can preload a model into a run" do
      m = Metric.define :my_model_metric, :model_name => :dog do |run|
        run[:model].count
      end

      m.current[:value].should == 3 # defined in mock_model.rb
    end

    it "can be called for the last day" do
      m = Metric.define :test_start_metric do |run|
        1
      end
      m.current[:start].should > 1.day.ago - 1.minute && m.current[:start].should < 1.day.ago + 1.minute
      m.current[:end].should > 1.minute.ago
    end

    it "can be called for a longer time period" do
      m = Metric.define :days_difference do |run|
        ((run[:end] - run[:start]) / 1.day).to_i
      end

      m.for_period(5.days.ago, 2.days.ago)[:value].should == 3
    end
  end
end