module Day4

  class << self

    def solution
      winners = []
      input = File.open('input.txt').read
      draws, *boards = input.split("\n\n")
      draw_sequence = draws.split(',')
      boards = boards.map { |b| Board.new(b) }
      draw_sequence.each do |draw|
        boards.each do |board|
          result = board.mark(draw)
          winners << result if result
        end
      end
      # Part one
      puts winners.first
      # Part Two
      puts winners.last
    end

  end
end

class Board
  def initialize(board)
    @completed = false
    @numbers = Hash.new
    board = board.split("\n").map { |row| row.split(' ') }
    @rows_count = board.count
    @cols_count = board.first.count
    board.each_with_index do |row, row_index|
      row.each_with_index do |number, col_index|
        @numbers[number] = {
          i: row_index,
          j: col_index,
          marked: false
        }
      end
    end
  end

  def mark(number)
    return unless @numbers[number]
    @numbers[number][:marked] = true
    return if @completed
    if check_marked!
      calculate_score(number)
    else
      false
    end
  end

  def calculate_score(number)
    unchecked_numbers = @numbers.select { |k, v| v[:marked] == false }
    unchecked_numbers.keys.map(&:to_i).sum * number.to_i
  end

  def check_marked!
    checked_numbers = @numbers.select { |k, v| v[:marked] == true }
    if checked_numbers.group_by { |k, v| v[:i] }.any? { |row| row[1].length == @rows_count } ||
       checked_numbers.group_by { |k, v| v[:j] }.any? { |col| col[1].length == @cols_count }
       @completed = true
      return true
    end
    false
  end
end

Day4.solution