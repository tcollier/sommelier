require 'sommelier/match_catalog'

class Sommelier
  describe MatchCatalog do
    describe '#most_preferred_dish' do
      subject(:catalog) { described_class.new }

      before do
        catalog.add('A', 'X', 2)
        catalog.add('B', 'X', 3)
        catalog.add('C', 'X', 4)
        catalog.add('B', 'Z', 9)
      end

      it 'returns the highest matched dish in the set' do
        expect(catalog.most_preferred_dish('X', ['A', 'B'])).to eq('B')
      end
    end
  end
end
