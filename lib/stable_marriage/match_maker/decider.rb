class StableMarriage
  class MatchMaker
    class Decider
      def initialize(match_set)
        @match_set = match_set
      end

      # Decide a single suitor's proposal to accept for each suitee
      #
      # @param provisional [Hash<Object, Array<Object>>] mapping of suitees to
      #   the list of suitors that have proposed in the current round
      # @param accepted [Hash<Object, Object>] mapping of suitors to the suitee
      #   that has accepted his proposal
      # @param reversed [Hash<Object, Object>] mapping of suitees to the suitor
      #   that has his proposal accepted by suitee
      def decide!(provisional, accepted, reversed)
        provisional.each do |suitee, current_suitors|
          # Be sure to consider the full set of current suitors and potentially
          # a suitor from a prior round who had his proposal accepted by the
          # suitee.
          prior_accepted_suitor = reversed[suitee]
          suitors = current_suitors + [*prior_accepted_suitor]
          winning_suitor = match_set.most_preferred(suitee, suitors)

          if prior_accepted_suitor != winning_suitor
            accepted.delete(prior_accepted_suitor)
            accepted[winning_suitor] = suitee
            reversed[suitee] = winning_suitor
          end
        end
      end

      private

      attr_reader :match_set
    end
    private_constant :Decider
  end
end
