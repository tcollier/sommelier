class StableMarriage
  class MatchMaker
    class Generator
      def initialize(match_set)
        @match_set = match_set
      end

      # Generate all of the provisional proposals for a single round of the
      # algorithm. Each suitor that isn't currently locked in a proposal from a
      # prior round and hasn't exhausted his list of preferred suitees will
      # propose to the highest matching suitee he has not yet proposed to.
      #
      # @param round [Integer] the round number
      # @param accepted [Hash<Object, Object>] mapping of suitors to the suitee
      #   that has accepted his proposal
      # @return [Hash<Object, Array<Object>>] mapping of suitees to the list of
      #   suitors that have proposed in the current round
      def proposals(round, accepted)
        provisional = {}
        match_set.each_suitor do |suitor, preferences_count|
          if round < preferences_count && !accepted.key?(suitor)
            suitee = match_set.suitee_preferred_at(suitor, round)
            provisional[suitee] ||= []
            provisional[suitee] << suitor
          end
        end
        provisional
      end

      private

      attr_reader :match_set
    end
    private_constant :Generator
  end
end
