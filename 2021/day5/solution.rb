Point = Struct.new(:x, :y)

module Day5
  class << self
    def part_one
      input = File.readlines('input.txt', chomp: true)
      points = input.map do |row|
        Line.new(*row.split(' -> ')).points
      end
      points = points.flatten.compact
      puts points.group_by(&:itself).transform_values(&:count).select { |k, v| v > 1 }.count
    end

    def part_two
      input = File.readlines('input.txt', chomp: true)
      points = input.map do |row|
        Line.new(*row.split(' -> ')).points(consider_diagonal: true)
      end
      points = points.flatten.compact
      puts points.group_by(&:itself).transform_values(&:count).select { |k, v| v > 1 }.count
    end
  end
end

class Line
  attr_reader :point1, :point2

  def initialize(point1, point2)
    @point1 = Point.new(*point1.split(',').map(&:to_i))
    @point2 = Point.new(*point2.split(',').map(&:to_i))
  end

  def points(consider_diagonal: false)
    return if (@point1.x != @point2.x && @point1.y != @point2.y && !consider_diagonal)

    if @point1.x == @point2.x
      ([@point1.y, @point2.y].min..[@point1.y, @point2.y].max).to_a.map do |y|
        "#{@point1.x},#{y}"
      end
    elsif @point1.y == @point2.y
      ([@point1.x, @point2.x].min..[@point1.x, @point2.x].max).to_a.map do |x|
        "#{x},#{@point1.y}"
      end
    else
      xs = ([@point1.x, @point2.x].min..[@point1.x, @point2.x].max).to_a.sort_by { |number| @point1.x > @point2.x ? -number : number }
      ys = ([@point1.y, @point2.y].min..[@point1.y, @point2.y].max).to_a.sort_by { |number| @point1.y > @point2.y ? -number : number }
      xs.map.with_index { |value, index| "#{value},#{ys[index]}" }
    end
  end
end

Day5.part_one
Day5.part_two