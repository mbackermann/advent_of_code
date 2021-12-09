data = File.readlines('input.txt', chomp: true).map(&:to_i)

# Part one
qty = data.select.with_index do |val, idx|
  val > data[idx - 1]
end.count
puts qty

# Part two
windows = data.map.with_index do |val, idx|
  [val, data[idx + 1], data[idx + 2]]
end.select { |m| m.all? }

qty = windows.select.with_index do |val, idx|
  next if idx == windows.length - 1
  val[0] < windows[idx + 1][2]
end.count
puts qty