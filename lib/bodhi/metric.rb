require 'active_support/all'

module Bodhi
  class Metric
    extend CountMetrics
    extend AggregateMetrics

    @@metrics = []

    def self.define (*args, &block)
      options = args.extract_options!
  
      options[:name] = args[0] if args[0].is_a? Symbol
      options[:block] ||= block if block

      m = Metric.new (options)
      @@metrics << m

      m
    end

    def self.generate_all
      @@metrics.each { |m| m.generate }
    end

    attr_accessor :name, :model_name, :block

    def initialize (params)
      @name = params[:name]
      @model_name = params[:model_name]
      @block = params[:block]
    end

    def current
      for_period 1.day.ago, Time.now
    end

    def for_period (start_date, end_date)
      # run for the last hour
      run = get_run_opts
      run[:start] = start_date
      run[:end] = end_date
      
      {:start => start_date, :end => end_date, :value => @block.call(run)}
    end

    def generate
      last_run = MetricValue.maximum(:end, :conditions => ["metric = '#{self.name}'"]) || Date.yesterday
      start_date = (last_run + 1.day).beginning_of_day
      end_date = start_date + 1.day - 1.second
      value = for_period start_date, end_date

      MetricValue.create!(:start => start_date, :end => end_date, :value => value[:value], :metric => self.name)
    end

    private
      def get_run_opts
        opts = {}
        opts[:model] = @model_name.to_s.classify.constantize if @model_name
        opts
      end
  end
end