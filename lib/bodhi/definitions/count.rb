module Bodhi
  module CountMetrics
    def count (*args)
      options = args.extract_options!
      options[:model_name] = args[0] if args[0].is_a? Symbol || args[0].is_a? String
      count_type = args[1] || options[:count_type] || :total
      options[:block] = get_block(count_type)
      options[:name] ||= "#{options[:model_name]}_count_#{count_type}"

      define(options)
    end

    protected
      def get_block(count_type)
        case count_type
        when :new
          lambda { |run| run[:model].where("created_at between ? and ?", run[:start], run[:end]).count }
        when :updated
          lambda { |run| run[:model].where("updated_at between ? and ?", run[:start], run[:end]).count }
        when :total
          lambda { |run| run[:model].count }
        end
      end
  end
end