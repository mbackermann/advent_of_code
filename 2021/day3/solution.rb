class Day3
  REPORT = File.readlines('input.txt', chomp: true).map(&:chars)

  class << self

    def part_one
      gamma_rate = REPORT.transpose.map { |bits| bits.max_by { |bit| bits.count(bit) } }.join.to_i(2)
      epsilon_rate = gamma_rate ^ (2**12 - 1)
      power_consumption = gamma_rate * epsilon_rate
      puts power_consumption
    end

    def part_two
      o2 = calculate_o2(REPORT.dup)
      co2 = calculate_co2(REPORT.dup)
      puts o2 * co2
    end

    private

    def calculate_o2(bits)
      bits[0].size.times do |index|
        bit = '1'

        if bits.count { |o| o[index] == '0' } > bits.size / 2.0
          bit = '0'
        end

        bits.select! { |o| o[index] == bit }

        break if bits.count == 1
      end
      bits.join.to_i(2)
    end

    def calculate_co2(bits)
      bits[0].size.times do |index|
        bit = '0'

        if bits.count { |o| o[index] == '1' } < bits.size / 2.0
          bit = '1'
        end

        bits.select! { |o| o[index] == bit }

        break if bits.count == 1
      end
      bits.join.to_i(2)
    end
  end
end

Day3.part_one
Day3.part_two