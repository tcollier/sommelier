require 'sommelier'

describe 'full preferences solution' do
  subject(:sommelier) { Sommelier.new }

  before do
    sommelier.add_match('A', 'X', 1)
    sommelier.add_match('A', 'Y', 5)
    sommelier.add_match('A', 'Z', 8)
    sommelier.add_match('B', 'X', 2)
    sommelier.add_match('B', 'Y', 3)
    sommelier.add_match('B', 'Z', 9)
    sommelier.add_match('C', 'X', 7)
    sommelier.add_match('C', 'Y', 6)
    sommelier.add_match('C', 'Z', 4)
  end

  describe '#pairings' do
    it 'includes a complete pairing for all dishes and wines' do
      pairings = sommelier.pairings
      expect(pairings.length).to eq(3)
      expect(pairings).to have_key('A')
      expect(pairings).to have_key('B')
      expect(pairings).to have_key('C')
      expect(pairings['A']).to eq('Y')
      expect(pairings['B']).to eq('Z')
      expect(pairings['C']).to eq('X')
    end
  end
end
