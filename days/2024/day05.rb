# frozen_string_literal: true

def parse_input
  File.readlines('data/2024/05/data.txt', chomp: true)
      .reduce([[], [], false]) do |(rules, updates, part2), line|
    next [rules, updates, true] if line == ''
    next [rules + [line], updates, false] unless part2

    [rules, updates + [line.split(',').map { |i| Integer(i) }], true]
  end
end

def setup_dag(rules)
  rules.each_with_object({}) do |rl, d|
    l, r = rl.split('|').map { |i| Integer(i) }
    d[l] = (d[l] || Set[]) + Set[r]
  end
end

def validate(update, dag)
  update.each_with_index do |v, i|
    next if i.zero?

    have_seen = Set[*update[0..(i - 1)]]
    shouldnt_have_seen = dag[v].nil? ? Set[] : dag[v]
    illegal_overlap = have_seen & shouldnt_have_seen

    return false unless illegal_overlap.empty?
  end

  true
end

def middle_page_if_fixed(update, dag)
  before = update.clone
  after = update.each_with_index.each_with_object(update) do |(v, i), fixed|
    next fixed if i.zero?

    have_seen = Set[*update[0..(i - 1)]]
    shouldnt_have_seen = dag[v].nil? ? Set[] : dag[v]
    illegal_overlap = have_seen & shouldnt_have_seen

    next fixed if illegal_overlap.empty?

    earliest_issue = illegal_overlap.map { |iss| fixed.index(iss) }.min
    fixed.delete_at(i)
    fixed.insert(earliest_issue, v)
  end

  if before == after
    0
  else
    after[(after.size.to_f / 2).floor]
  end
end

rules, updates = parse_input
dag = setup_dag(rules)

p(updates.select { |u| validate(u, dag) }.map { |u| u[(u.size.to_f / 2).floor] }.sum)
p(updates.map { |u| middle_page_if_fixed(u, dag) }.sum)
