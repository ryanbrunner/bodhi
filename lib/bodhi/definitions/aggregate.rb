module Bodhi
  module AggregateMetrics
    def average (*args)
      aggregate *args.unshift(:average)
    end

    def sum (*args)
      aggregate *args.unshift(:sum)
    end

    def maximum (*args)
      aggregate *args.unshift(:maximum)
    end

    def minimum (*args)
      aggregate *args.unshift(:minimum)
    end

    def aggregate (*args)
      options = args.extract_options!

      agg_method = args[0]
      options[:model_name] = args[1]
      field = args[2]

      options[:block] = get_agg_block(agg_method, field)
      options[:name] ||= "#{options[:model_name]}_#{agg_method}_#{field}"

      define(options)
    end

    protected
      def get_agg_block(agg_method, field)
        lambda { |run| run[:model].calculate(agg_method, field)}
      end

  end
end