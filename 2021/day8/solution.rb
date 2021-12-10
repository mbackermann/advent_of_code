module Day8
  class << self
    LETTERS_MAP = {
      0 => 'abcefg',
      1 => 'cf',
      2 => 'acdeg',
      3 => 'acdfg',
      4 => 'bcdf',
      5 => 'abdfg',
      6 => 'abdefg',
      7 => 'acf',
      8 => 'abcdefg',
      9 => 'abcdfg'
    }.freeze

    UNIQUE_LETTERS = [2, 3, 4, 7].freeze

    def part_one
      input = File.readlines('input.txt', chomp: true)
      occurrences = input.map do |line|
        line
          .split(' | ')
          .last
          .split(' ')
          .collect(&:length)
          .select { |length| UNIQUE_LETTERS.include?(length) }
          .size
      end.sum
      puts occurrences
    end

    def part_two
      data = File.readlines('input.txt', chomp: true).map do |line|
        line.split(' | ').map do |x|
          x.split(' ').map do |c|
            c.chars.sort
          end
        end
      end
      result = data.map do |input, output|
        mapping = digit_mapping(input)
        output.map { |digit| mapping.key digit }.join.to_i
      end.sum
      puts result
    end

    private

    def digit_mapping(input)
      mapping = {}

      mapping[1] = input.find { |p| p.size == 2 }
      mapping[4] = input.find { |p| p.size == 4 }
      mapping[7] = input.find { |p| p.size == 3 }
      mapping[8] = input.find { |p| p.size == 7 }
      mapping[6] = input.find { |p| p.size == 6 && (p - mapping[1]).size == 5 }
      mapping[9] = input.find { |p| p.size == 6 && (p - mapping[4]).size == 2 }
      mapping[0] = input.find { |p| p.size == 6 && p != mapping[6] && p != mapping[9] }
      mapping[3] = input.find { |p| p.size == 5 && (p - mapping[1]).size == 3 }
      mapping[2] = input.find { |p| p.size == 5 && (p - mapping[9]).size == 1 }
      mapping[5] = input.find { |p| p.size == 5 && p != mapping[2] && p != mapping[3] }

      mapping
    end
  end
end

Day8.part_one
Day8.part_two
