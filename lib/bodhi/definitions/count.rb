module Bodhi
  module CountMetrics
    def count (*args)
      model_name = args[0]
      count_type = args[1] || :total

      define(:model_name => model_name,
             :block => get_block(count_type) )
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