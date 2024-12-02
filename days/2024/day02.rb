# frozen_string_literal: true

def read_input(fname)
  File.readlines(fname, chomp: true).map { |ln| ln.split.map(&:to_i) }
end

def arr_except_idx(arr, idx)
  arr.reject.with_index { |_, i| i == idx }
end

def check_report(report)
  sorted = report.sort
  return false unless report == sorted || report == sorted.reverse

  1.step(to: report.length - 1).each do |i|
    diff = (report[i] - report[i - 1]).abs
    return false unless [1, 2, 3].include?(diff)
  end

  true
end

def dampened_check_report(report)
  return true if check_report(report)

  0.step(to: report.length - 1).each do |i|
    return true if check_report(arr_except_idx(report, i))
  end

  false
end

def part1
  reports = read_input('data/2024/02/data.txt')
  reports.count { |report| check_report(report) }
end

def part2
  reports = read_input('data/2024/02/data.txt')
  reports.count { |report| dampened_check_report(report) }
end

p part1
p part2
