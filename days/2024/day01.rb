# frozen_string_literal: true

def read_input(fname)
  arr = File.readlines(fname, chomp: true).map { |ln| ln.split.map(&:to_i) }
  [arr.map(&:first).sort, arr.map(&:last).sort]
end

def part1
  left, right = read_input('data/2024/01/data.txt')
  left.each_with_index.map { |e, i| (e - right[i]).abs }.sum
end

def part2
  left, right = read_input('data/2024/01/data.txt')
  left.inject(0) { |sum, l| sum + l * right.count(l) }
end

p part1
p part2
