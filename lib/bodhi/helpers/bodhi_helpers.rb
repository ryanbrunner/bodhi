module Bodhi
  module Helpers
    def chart_for(*args)
      options = args.extract_options!
      
      metric = Bodhi::Metric[args[0]]
      start_date = options[:start] || 1.month.ago
      end_date = options[:end] || Time.now
      width = options[:width] || "500px"
      height = options[:height] || "200px"

      chart_tag(metric, start_date, end_date, {:width => width, :height => height}).html_safe
    end

    private
      def chart_tag(metric, start_date, end_date, data_params)
        values = metric.for_period(start_date, end_date)
        data_string = data_params.map{ |k,v| "data-#{k}='#{v}'" }.join(" ")

        res = "<table class='bodhi-chart' data-metric='#{metric.name}' #{data_string} >"
        values.each do |v|
          res += "<tr><th>#{v.start.strftime("%Y-%m-%d")}</th><td>#{v.value}</td></tr>"
        end
        res += "</table>"
        res
      end

  end
end



