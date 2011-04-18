require 'spec_helper'

module Bodhi
  describe Metric do
    it "should persist to MetricValue when generate is called" do
      m = Metric.define :dummy do
        1
      end

      m.generate

      MetricValue.where(:metric => 'dummy').count.should == 1
    end

    it "should persist to MetricValue when generate_all is called" do
      m1 = Metric.define :multi_dummy1 do
        1
      end

      m2 = Metric.define :multi_dummy2 do
        2
      end

      Metric.generate_all

      MetricValue.where(:metric => 'multi_dummy1').count.should == 1
      MetricValue.where(:metric => 'multi_dummy2').count.should == 1
    end
  end
end