# frozen_string_literal: true

def parse_input(regex)
  File.read('data/2024/03/data.txt').scan(regex).flatten
end

def run_mul(mul)
  mul.scan(/\d+/).map(&:to_i).inject(:*)
end

def run_rec(instructions, mul_enabled: true)
  case instructions
  in [/mul.*/, *rest]
    (mul_enabled ? run_mul(instructions[0]) : 0) + run_rec(rest, mul_enabled:)
  in [/do\(\)/, *rest]
    run_rec(rest, mul_enabled: true)
  in [/don't\(\)/, *rest]
    run_rec(rest, mul_enabled: false)
  in []
    0
  end
end

puts 'part 1'
instructions = parse_input(/mul\(\d+,\d+\)/)
p run_rec(instructions, mul_enabled: true)

puts 'part 2'
instructions = parse_input(/mul\(\d+,\d+\)|do\(\)|don't\(\)/)
p run_rec(instructions, mul_enabled: true)
