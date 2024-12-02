# frozen_string_literal: true

def read_input(fname)
  File.readlines(fname, chomp: true).map { |ln| ln.split.map(&:to_i) }
end

def check(report)
  inc_or_dec = -> { report == report.sort || report == report.sort.reverse }
  small_diff = -> { report.each_cons(2).map { |x, y| (x - y).abs }.to_set - Set[1, 2, 3] == Set[] }

  inc_or_dec.call && small_diff.call
end

reports = read_input('data/2024/02/data.txt')
puts('part1', reports.count { |rep| check(rep) })
puts('part2', reports.count { |rep| rep.each_index.any? { |i| check(rep.reject.with_index { |_, j| j == i }) } })
