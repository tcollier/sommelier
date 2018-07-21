class StableMarriage
  describe MatchSet do
    describe '#most_preferred' do
      subject(:match_set) { described_class.new }

      before do
        match_set.add('A', 'X', 2)
        match_set.add('B', 'X', 3)
        match_set.add('C', 'X', 4)
        match_set.add('B', 'Z', 9)
      end

      it 'returns the highest matched suitor in the set' do
        expect(match_set.most_preferred('X', ['A', 'B'])).to eq('B')
      end
    end
  end
end
