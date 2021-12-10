module Day6
  NEW_FISH_DAYS = 8
  NEW_CICLE_DAYS = 6

  class << self

    # O(2ˆn)
    def part_one
      initial_lanternfish = File.open('input.txt').read.split(',').map { |n| Lanternfish.new(n.to_i) }
      lanternfish = number_of_lanternfish(initial_lanternfish, 80)
      puts lanternfish.size
    end

    # O(n)
    def part_two
      initial_lanternfish = File.open('input.txt').read.split(',').collect(&:to_i)
      lanternfish = (0..NEW_FISH_DAYS + 1).map { |day| initial_lanternfish.count(day) }
      256.times do
        lanternfish = next_day(lanternfish)
      end

      puts lanternfish.sum
    end

    private

    # Part One
    def number_of_lanternfish(initial_lanternfish, days)
      lanternfish = initial_lanternfish
      days.times do |i|
        lanternfish = lanternfish.map(&:decrease_internal_timer_value).flatten
      end
      lanternfish
    end

    # Part Two
    def next_day(fish)
      new_fish = fish.drop(1)
      new_fish << 0

      new_fish[NEW_FISH_DAYS] += fish[0]
      new_fish[NEW_CICLE_DAYS] += fish[0]

      new_fish
    end
  end
end

class Lanternfish
  attr_accessor :internal_timer_value

  def initialize(internal_timer_value = nil)
    @internal_timer_value = internal_timer_value || 8
  end

  def decrease_internal_timer_value
    if @internal_timer_value == 0
      @internal_timer_value = 6
      return [self, Lanternfish.new]
    else
      @internal_timer_value -= 1
      self
    end
  end
end

Day6.part_one
Day6.part_two