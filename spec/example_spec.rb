require 'spec_helper'

RSpec.describe 'Example' do
  it 'is an example test' do
    expect(1 + 1).to eq(2)
  end

  it 'does' do
    y = [1, 2, 4, 3, { a: 14, b: 17, c: 19 }, 'abc']
    a_match = 15
    y => [*o, { a: ^a_match, **xyz }, sss]

    p o

    p sss
    p xyz

    case y
    in [1, *, 3]
      puts 'hey'
    else
      # type code here
    end
  end
end
