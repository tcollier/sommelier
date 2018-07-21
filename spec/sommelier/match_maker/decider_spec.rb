require 'sommelier/match_maker/decider'
require 'sommelier/match_catalog'

class Sommelier
  class MatchMaker
    describe Decider do
      describe '#decide!' do
        subject(:decider) { described_class.new(catalog) }

        let(:catalog) { MatchCatalog.new }

        before do
          catalog.add('A', 'X', 1)
        end

        it 'adds the accepted dish => wine mapping to `accepted`' do
          requests = { 'X' => ['A'] }
          accepted = {}
          decider.decide!(requests, accepted, {})
          expect(accepted).to have_key('A')
          expect(accepted['A']).to eq('X')
        end

        it 'adds the accepted wine => dish mapping to `reveresed`' do
          requests = { 'X' => ['A'] }
          reversed = {}
          decider.decide!(requests, {}, reversed)
          expect(reversed).to have_key('X')
          expect(reversed['X']).to eq('A')
        end

        context 'when the wine has 2 dishes to choose from' do
          before do
            catalog.add('B', 'X', 2)
          end

          it 'adds the higher matched dish to `accepted`' do
            requests = { 'X' => ['A', 'B'] }
            accepted = {}
            decider.decide!(requests, accepted, {})
            expect(accepted).to have_key('B')
            expect(accepted['B']).to eq('X')
          end

          it 'adds the higher matched dish to `reversed`' do
            requests = { 'X' => ['A', 'B'] }
            reversed = {}
            decider.decide!(requests, {}, reversed)
            expect(reversed).to have_key('X')
            expect(reversed['X']).to eq('B')
          end
        end

        context 'when the wine subsuently sees a better dish' do
          before do
            catalog.add('B', 'X', 2)
          end

          it 'removes the old dish from `accepted`' do
            requests = { 'X' => ['B'] }
            accepted = { 'A' => 'X' }
            reversed = { 'X' => 'A' }
            decider.decide!(requests, accepted, reversed)
            expect(accepted).to_not have_key('A')
          end
        end

        context 'when the wine subsuently sees a worse dish' do
          before do
            catalog.add('B', 'X', 0)
          end

          it 'does not change state' do
            requests = { 'X' => ['B'] }
            accepted = { 'A' => 'X' }
            reversed = { 'X' => 'A' }
            decider.decide!(requests, accepted, reversed)
            expect(accepted).to_not have_key('A' => 'X')
            expect(reversed).to_not have_key('X' => 'A')
          end
        end
      end
    end
  end
end
