# frozen_string_literal: true

def parse_input
  lines = File.readlines('data/2024/06/data.txt', chomp: true)
  lines.each_with_index.reduce({ DIR: :UP, LOOPS: 0 }) do |map, (l, y)|
    l.split('').each_with_index.reduce(map) do |m, (p, x)|
      if p == '^'
        m.merge(:GUARD => [x, y], :VISITED => Set[[x, y]], [x, y] => '.')
      else
        m.merge([x, y] => p)
      end
    end
  end.merge(WIDTH: lines[0].length, HEIGHT: lines.length)
end

def oob?(map, x, y)
  x.negative? || y.negative? || x >= map[:WIDTH] || y >= map[:HEIGHT]
end

TURN = { UP: :RIGHT, RIGHT: :DOWN, DOWN: :LEFT, LEFT: :UP }.freeze

def move(map, to)
  return [:DONE, map] if oob?(map, *to)
  return [nil, map.merge(DIR: TURN[map[:DIR]])] if map[to] == '#'

  [nil, map.merge(GUARD: to, VISITED: map[:VISITED] + [to])]
end

def step(map)
  x, y = map[:GUARD]
  case map[:DIR]
  when :UP
    move(map, [x, y - 1])
  when :RIGHT
    move(map, [x + 1, y])
  when :DOWN
    move(map, [x, y + 1])
  when :LEFT
    move(map, [x - 1, y])
  end
end

def solve(status, map)
  return map if status == :DONE

  solve(*step(map))
end

map = parse_input
solved = solve(nil, map)

p "part1"
p solved[:VISITED].length
p "part2"
p solved[:LOOPS]