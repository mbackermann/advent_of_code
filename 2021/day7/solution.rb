module Day7

  class << self

    # Using median
    def part_one
      crab_positions = File.open('input.txt').read.split(',').map(&:to_i)
      puts calculate_fuel(crab_positions)
    end

    def part_two
      crab_positions = File.open('input.txt').read.split(',').map(&:to_i)
      puts calculate_fuel_expensive(crab_positions)
    end

    def median(array)
      return nil if array.empty?

      sorted = array.sort
      length = sorted.length
      ((sorted[(length - 1) / 2] + sorted[length / 2]) / 2).to_i
    end

    def calculate_fuel(crab_positions)
      pos = median(crab_positions)
      crab_positions.sum do |crab_pos|
         (crab_pos - pos).abs
      end
    end

    def calculate_fuel_expensive(crab_positions)
      Range.new(*crab_positions.minmax).map do |position|
        crab_positions.sum do |i|
          fuel = (i - position).abs
          fuel * (fuel + 1) / 2
        end
      end.min
    end
  end
end

Day7.part_one
Day7.part_two