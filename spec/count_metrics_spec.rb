require 'spec_helper'

module Bodhi
  describe Metric do
    it "should calculate the count of a model" do
      m = Metric.count :dogs

      m.current[:value].should == 3
    end

    it "should be able to count new models" do
      m = Metric.count :dogs, :new

      m.current[:value].should == 1 # 1 dog created in the last hour
    end

    it "should be able to count updated models" do
      m = Metric.count :dogs, :updated

      m.current[:value].should == 2 # 2 dogs updated in the last hour
    end
  end


end