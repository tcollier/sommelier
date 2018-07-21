require 'stable_marriage/match_maker/decider'
require 'stable_marriage/match_set'

class StableMarriage
  class MatchMaker
    describe Decider do
      describe '#decide!' do
        subject(:decider) { described_class.new(match_set) }

        let(:match_set) { MatchSet.new }

        before do
          match_set.add('A', 'X', 1)
        end

        it 'adds the accepted suitor => suitee mapping to `accepted`' do
          provisional = { 'X' => ['A'] }
          accepted = {}
          decider.decide!(provisional, accepted, {})
          expect(accepted).to have_key('A')
          expect(accepted['A']).to eq('X')
        end

        it 'adds the accepted suitee => suitor mapping to `reveresed`' do
          provisional = { 'X' => ['A'] }
          reversed = {}
          decider.decide!(provisional, {}, reversed)
          expect(reversed).to have_key('X')
          expect(reversed['X']).to eq('A')
        end

        context 'when the suitee has 2 suitors to choose from' do
          before do
            match_set.add('B', 'X', 2)
          end

          it 'adds the higher matched suitor to `accepted`' do
            provisional = { 'X' => ['A', 'B'] }
            accepted = {}
            decider.decide!(provisional, accepted, {})
            expect(accepted).to have_key('B')
            expect(accepted['B']).to eq('X')
          end

          it 'adds the higher matched suitor to `reversed`' do
            provisional = { 'X' => ['A', 'B'] }
            reversed = {}
            decider.decide!(provisional, {}, reversed)
            expect(reversed).to have_key('X')
            expect(reversed['X']).to eq('B')
          end
        end

        context 'when the suitee subsuently sees a better suitor' do
          before do
            match_set.add('B', 'X', 2)
          end

          it 'removes the old suitor from `accepted`' do
            provisional = { 'X' => ['B'] }
            accepted = { 'A' => 'X' }
            reversed = { 'X' => 'A' }
            decider.decide!(provisional, accepted, reversed)
            expect(accepted).to_not have_key('A')
          end
        end

        context 'when the suitee subsuently sees a worse suitor' do
          before do
            match_set.add('B', 'X', 0)
          end

          it 'does not change state' do
            provisional = { 'X' => ['B'] }
            accepted = { 'A' => 'X' }
            reversed = { 'X' => 'A' }
            decider.decide!(provisional, accepted, reversed)
            expect(accepted).to_not have_key('A' => 'X')
            expect(reversed).to_not have_key('X' => 'A')
          end
        end
      end
    end
  end
end
