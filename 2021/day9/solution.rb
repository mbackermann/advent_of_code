module Day9
  class << self
    INPUT = File.readlines('input.txt', chomp: true).map { |l| l.chars.map(&:to_i) }.freeze
    def part_one
      puts low_points.map { |i,j| INPUT[i][j] + 1 }.sum
    end

    def part_two
      puts low_points.map { |(i, j)| basin_adjacents(i, j).count }.sort.last(3).inject(:*)
    end

    private

    def find_adjacents(i,j)
      adjacents = [
        [-1, 0],
        [1, 0],
        [0, -1],
        [0, 1],
      ]

      adjacents.filter_map do |i2, j2|
        ni = i + i2
        nj = j + j2

        next if ni < 0 || ni >= INPUT.size
        next if nj < 0 || nj >= INPUT.first.size

        [ni, nj]
      end
    end

    def low_point?(i, j)
      find_adjacents(i, j).all? { |x, y| INPUT[x][y] > INPUT[i][j] }
    end

    def low_points
      low_points = []
      for i in 0..INPUT.size - 1 do
        for j in 0..INPUT.first.size - 1 do
          low_points << [i,j] if low_point?(i, j)
        end
      end
      low_points
    end

    def basin_adjacents(i, j)
      adjacents = find_adjacents(i, j).select do |x, y|
        INPUT[x][y] > INPUT[i][j] && INPUT[x][y] != 9
      end

      [[i, j]] + adjacents.flat_map { |(x, y)| basin_adjacents(x, y) }.uniq
    end
  end
end

Day9.part_one
Day9.part_two