require 'stable_marriage'

describe 'full preferences solution' do
  subject(:stable_marriage) { StableMarriage.new }

  before do
    stable_marriage.add_match('A', 'X', 1)
    stable_marriage.add_match('A', 'Y', 5)
    stable_marriage.add_match('A', 'Z', 8)
    stable_marriage.add_match('B', 'X', 2)
    stable_marriage.add_match('B', 'Y', 3)
    stable_marriage.add_match('B', 'Z', 9)
    stable_marriage.add_match('C', 'X', 7)
    stable_marriage.add_match('C', 'Y', 6)
    stable_marriage.add_match('C', 'Z', 4)
  end

  describe '#proposals' do
    it 'solves' do
      proposals = stable_marriage.proposals
      expect(proposals.length).to eq(3)
      expect(proposals).to have_key('A')
      expect(proposals).to have_key('B')
      expect(proposals).to have_key('C')
      expect(proposals['A']).to eq('Y')
      expect(proposals['B']).to eq('Z')
      expect(proposals['C']).to eq('X')
    end
  end
end
