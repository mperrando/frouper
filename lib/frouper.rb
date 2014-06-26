require "frouper/version"

module Frouper
  class Frouper
    class Item
      def initialize date
        @date = date
      end

      def << value
        @max = [(@max || value), value].max
        @min = [(@min || value), value].min
        @sum = (@sum || 0) + value
        @count = (@count || 0) + 1
      end

      def date
        @date
      end

      def high
        @max
      end

      def low
        @min
      end

      def center
        @sum / @count
      end

      def to_s
        "<#{date}: #{high}, #{center}, #{low}>"
      end
    end

    def initialize start_date, end_date, size
      @start_date = start_date
      @end_date = end_date
      @size = size
      @items = {}
      @delta = (end_date - start_date) / size
    end

    def accumulate date, value
      date = date_for(date)
      item = @items[date] ||= Item.new(date)
      item << value
    end

    def accumulate_pairs pairs
      pairs.each { |v| accumulate v[0], v[1] }
    end

    def date_for date
      n = (date - @start_date) / @delta
      @start_date + (n + 0.5) * @delta
    end

    def to_s
      @items.to_s
    end

    def items
      @items.values
    end

    def series
      high = []
      low = []
      center = []
      items.sort_by(&:date).each do |item|
        high << [item.date, item.high]
        low << [item.date, item.low]
        center << [item.date, item.center]
      end
      [low, center, high]
    end
  end
end
