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
      agg_method = args[0]
      model_name = args[1]
      field = args[2]

      block = get_agg_block(agg_method, field)

      define(:model_name => model_name,
             :block => block )
    end

    protected
      def get_agg_block(agg_method, field)
        lambda { |run| run[:model].calculate(agg_method, field)}
      end

  end
end