require 'sommelier/match_catalog'

class Sommelier
  describe MatchCatalog do
    describe '#each_dish' do
      subject(:catalog) { described_class.new }

      before do
        catalog.add('A', 'X', 2)
        catalog.add('A', 'Y', 4)
        catalog.add('A', 'Z', 3)
        catalog.add('B', 'Z', 9)
      end

      it 'yields each dish along with the number of wines it is matched with' do
        found = {}
        catalog.each_dish do |dish, preferences_count|
          found[dish] = preferences_count
        end
        expect(found.length).to eq(2)
        expect(found).to have_key('A')
        expect(found).to have_key('B')
        expect(found['A']).to eq(3)
        expect(found['B']).to eq(1)
      end
    end

    describe '#wine_preferred_at' do
      subject(:catalog) { described_class.new }

      before do
        catalog.add('A', 'X', 2)
        catalog.add('A', 'Y', 4)
        catalog.add('A', 'Z', 3)
        catalog.add('B', 'Z', 9)
      end

      it 'returns the Nth preferred wine for the dish' do
        expect(catalog.wine_preferred_at('A', 2)).to eq('X')
      end
    end

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
