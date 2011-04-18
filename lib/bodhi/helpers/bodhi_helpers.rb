module Bodhi
  module Helpers
    def chart_for(*args)
      options = args.extract_options!
      
      metric = Bodhi::Metric[args[0]]
      start_date = options[:start] || 1.month.ago
      end_date = options[:end] || Time.now

      container_div(metric, start_date, end_date).html_safe
    end

    private
      def container_div(metric, start_date, end_date)
        values = metric.for_period(start_date, end_date).map { |v| v.value }.join(",")

        "<div data-metric='#{metric.name}' data-metric-data='#{values}'></div>"
      end

  end
end



