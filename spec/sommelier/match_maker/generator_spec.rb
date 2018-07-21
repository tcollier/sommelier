require 'sommelier/match_maker/generator'
require 'sommelier/match_catalog'

class Sommelier
  class MatchMaker
    describe Generator do
      describe '#requests' do
        subject(:generator) { described_class.new(catalog) }

        let(:catalog) { MatchCatalog.new }

        before do
          catalog.add('A', 'X', 1)
        end

        it 'generates a request' do
          requests = generator.requests(0, {})
          expect(requests.length).to eq(1)
          expect(requests).to have_key('X')
          expect(requests['X']).to eq(['A'])
        end

        context 'when the dish is already in an accepted pairing request' do
          it 'does not include the dish in the returned map' do
            requests = generator.requests(0, 'A' => 'Z')
            expect(requests.length).to eq(0)
          end
        end

        context 'when the round is beyond the length of dish preferences' do
          it 'does not include the dish in the returned map' do
            requests = generator.requests(1, {})
            expect(requests.length).to eq(0)
          end
        end

        context 'when two dishes have a preference for the wine' do
          before do
            catalog.add('B', 'X', 2)
          end

          it 'includes requests for both dishes' do
            requests = generator.requests(0, {})
            expect(requests.length).to eq(1)
            expect(requests).to have_key('X')
            expect(requests['X']).to match_array(['A', 'B'])
          end
        end
      end
    end
  end
end
