require 'active_support/all'

module Bodhi
  class Metric
    extend CountMetrics
    extend AggregateMetrics

    include Enumerable

    @@metrics = {}

    def self.define (*args, &block)
      options = args.extract_options!
  
      options[:name] = args[0] if args[0].is_a? Symbol
      options[:block] ||= block if block

      m = Metric.new (options)
      @@metrics[m.name] = m

      m
    end

    def self.[] (key)
      @@metrics[key]
    end

    def self.all
      @@metrics.each_value
    end

    def self.generate_all
      @@metrics.each_value { |m| m.generate }
    end

    attr_accessor :name, :model_name, :block

    def initialize (params)
      @name = params[:name]
      @model_name = params[:model_name]
      @block = params[:block]
    end

    def current
      @block.call(get_run_opts.merge(:start => Time.now.beginning_of_day, :end => Time.now.end_of_day))
    end

    def for_period (start_date, end_date = Time.now)
      MetricValue.where(:metric => @name).where("start between ? and ?", start_date, end_date)
    end

    def generate
      # Remove any runs from today 
      MetricValue.where(:metric => self.name).where("start >= ?", Date.today).destroy_all

      last_run = MetricValue.maximum(:end, :conditions => ["metric = '#{self.name}'"]) || Date.yesterday
      
      while last_run < Date.today
        start_date = (last_run + 1.day).beginning_of_day
        end_date = start_date + 1.day - 1.second
        value = @block.call(get_run_opts.merge(:start => start_date, :end => end_date))

        MetricValue.create!(:start => start_date, :end => end_date, :value => value, :metric => self.name)

        last_run = start_date
      end
    end

    private
      def get_run_opts
        opts = {}
        opts[:model] = @model_name.to_s.classify.constantize if @model_name
        opts
      end
  end
end