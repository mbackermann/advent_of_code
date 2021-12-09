data = File.readlines('input.txt', chomp: true)

# Part One
# pos = [horizontal, depth]
pos = [0,0]
data.each do |command|
  direction, distance = command.split(' ')
  case direction
  when 'forward'
    pos[0] += distance.to_i
  when 'down'
    pos[1] += distance.to_i
  when 'up'
    pos[1] -= distance.to_i
  end
end
puts pos.inject(:*)

# Part Two
# pos = [horizontal, depth, aim]
pos = [0,0,0]
data.each do |command|
  direction, distance = command.split(' ')
  case direction
  when 'forward'
    pos[0] += distance.to_i
    pos[1] += distance.to_i * pos[2]
  when 'down'
    pos[2] += distance.to_i
  when 'up'
    pos[2] -= distance.to_i
  end
end
puts pos.slice(0,2).inject(:*)