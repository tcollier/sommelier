require 'stable_marriage/match_maker/generator'
require 'stable_marriage/match_set'

class StableMarriage
  class MatchMaker
    describe Generator do
      describe '#proposals' do
        subject(:generator) { described_class.new(match_set) }

        let(:match_set) { MatchSet.new }

        before do
          match_set.add('A', 'X', 1)
        end

        it 'generates a proposal' do
          proposals = generator.proposals(0, {})
          expect(proposals.length).to eq(1)
          expect(proposals).to have_key('X')
          expect(proposals['X']).to eq(['A'])
        end

        context 'when the suitor is already in an accepted proposal' do
          it 'does not include the suitor in the returned map' do
            proposals = generator.proposals(0, 'A' => 'Z')
            expect(proposals.length).to eq(0)
          end
        end

        context 'when the round number is beyond the length of preferences' do
          it 'does not include the suitor in the returned map' do
            proposals = generator.proposals(1, {})
            expect(proposals.length).to eq(0)
          end
        end

        context 'when two suitors have a preference for the suitee' do
          before do
            match_set.add('B', 'X', 2)
          end

          it 'includes proposals for both suitors' do
            proposals = generator.proposals(0, {})
            expect(proposals.length).to eq(1)
            expect(proposals).to have_key('X')
            expect(proposals['X']).to match_array(['A', 'B'])
          end
        end
      end
    end
  end
end
