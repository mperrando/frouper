require "frouper/version"

module Frouper
  class Frouper
    class Item
      def initialize start_date, end_date
        @start_date = start_date
        @end_date = end_date
        @values = []
      end

      def << value
        @values << value
      end

      def date
        (@start_date + @end_date) / 2
      end

      def high
        @values.max
      end

      def low
        @values.min
      end

      def center
        @values.reduce(:+) / @values.size
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
      item = @items[date_for(date)] ||= Item.new(date, date + @delta)
      item << value
    end

    def accumulate_pairs pairs
      pairs.each { |v| accumulate v[0], v[1] }
    end

    def date_for date
      n = (date - @start_date) / @delta
      @start_date + n * @delta
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
      items.each do |item|
        high << [item.date, item.high]
        low << [item.date, item.low]
        center << [item.date, item.center]
      end
      [low, center, high]
    end
  end
end