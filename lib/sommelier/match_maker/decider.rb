class Sommelier
  class MatchMaker
    # Decide a single dish's pairing request to accept for each wine
    class Decider
      def initialize(match_catalog)
        @match_catalog = match_catalog
      end

      # Decide on which requested pairings to accepts (up to one per wine) and
      # update the `accepted` and `reversed` input maps.
      #
      # @param requests [Hash<Object, Array<Object>>] mapping of wines to
      #   the list of dishes that have requested pairing in the current round.
      # @param accepted [Hash<Object, Object>] mapping of dishes to the wine
      #   that has accepted its pairing request. Note: invoking this method may
      #   cause modifications to this object.
      # @param reversed [Hash<Object, Object>] mapping of wines to the dish
      #   that has its pairing request accepted by wine. Note: invoking this
      #   method may cause modifications to this object.
      def decide!(requests, accepted, reversed)
        requests.each do |wine, current_dishes|
          # Be sure to consider the full set of current dishes and potentially
          # a dish from a prior round who had its pairing request accepted by
          # the wine.
          prior_accepted_dish = reversed[wine]
          dishes = current_dishes + [*prior_accepted_dish]
          winning_dish = match_catalog.most_preferred_dish(wine, dishes)

          if prior_accepted_dish != winning_dish
            accepted.delete(prior_accepted_dish)
            accepted[winning_dish] = wine
            reversed[wine] = winning_dish
          end
        end
      end

      private

      attr_reader :match_catalog
    end
    private_constant :Decider
  end
end
