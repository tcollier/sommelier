class Sommelier
  class MatchMaker
    # Generate all of the requested pairings for a single round of the
    # algorithm. Each dish that isn't currently locked in a pairing from a
    # prior round and hasn't exhausted its list of preferred wines will
    # request a pairing with the highest matching wine it has not yet
    # requested.
    class Generator
      def initialize(match_catalog)
        @match_catalog = match_catalog
      end

      # @param round [Integer] the round number
      # @param accepted [Hash<Object, Object>] mapping of dishes to the wine
      #   that has accepted his pairing
      # @return [Hash<Object, Array<Object>>] mapping of wines to the list of
      #   dishes that have requested pairings in the current round
      def requests(round, accepted)
        requests = {}
        match_catalog.each_dish do |dish, preferences_count|
          if round < preferences_count && !accepted.key?(dish)
            wine = match_catalog.wine_preferred_at(dish, round)
            requests[wine] ||= []
            requests[wine] << dish
          end
        end
        requests
      end

      private

      attr_reader :match_catalog
    end
    private_constant :Generator
  end
end
