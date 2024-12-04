# frozen_string_literal: true

def parse_input
  File.readlines('data/2024/04/data.txt', chomp: true).each_with_index.reduce({}) do |map, (line, y)|
    line.each_char.with_index.reduce(map) { |m, (char, x)| m.merge!({ [x, y] => char }) }
  end
end

def xmas_count(map, x, y)
  nw = [1, 2, 3].reduce(map[[x, y]]) { |word, i| word + map[[x - i, y - i]].to_s }
  n = [1, 2, 3].reduce(map[[x, y]]) { |word, i| word + map[[x, y - i]].to_s }
  ne = [1, 2, 3].reduce(map[[x, y]]) { |word, i| word + map[[x + i, y - i]].to_s }
  e = [1, 2, 3].reduce(map[[x, y]]) { |word, i| word + map[[x + i, y]].to_s }
  se = [1, 2, 3].reduce(map[[x, y]]) { |word, i| word + map[[x + i, y + i]].to_s }
  s = [1, 2, 3].reduce(map[[x, y]]) { |word, i| word + map[[x, y + i]].to_s }
  sw = [1, 2, 3].reduce(map[[x, y]]) { |word, i| word + map[[x - i, y + i]].to_s }
  w = [1, 2, 3].reduce(map[[x, y]]) { |word, i| word + map[[x - i, y]].to_s }
  [nw, n, ne, e, se, s, sw, w].count { |word| word == 'XMAS' }
end

def part1(map)
  map.reduce(0) do |cnt, ((x, y), v)|
    next unless v == 'X'
    
    cnt + xmas_count(map, x, y)
  end
end

def part2(map)
  map.reduce(0) do |cnt, ((x, y), v)|
    next cnt unless v == 'A'

    left_diag = Set[map[[x - 1, y - 1]], map[[x, y]], map[[x + 1, y + 1]]]
    right_diag = Set[map[[x - 1, y + 1]], map[[x, y]], map[[x + 1, y - 1]]]
    next cnt unless left_diag == right_diag && right_diag == Set['M', 'A', 'S']

    cnt + 1
  end
end

p part1 parse_input
p part2 parse_input
