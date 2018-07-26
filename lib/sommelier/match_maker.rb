require_relative 'match_maker/generator'
require_relative 'match_maker/decider'

class Sommelier
  # Implementation of a variation of the Gale-Shapley algorithm. In this
  # variation, every dish that isn't currently in a pairing and hasn't exhausted
  # its list of preferred wines will attempt a pairing with its highest
  # matching wine that it has not yet attempt to pair with.
  #
  # Once all of the pairings for a round are made, then wines will accept
  # only the highest matching dish that has attempted to pair with it. It will
  # reject all others, even if it had previously accepted the pairing in a prior
  # round.
  class MatchMaker
    def initialize(match_catalog)
      @match_catalog = match_catalog
    end

    # Return a set of pairings. Given that not all of the Gale-Shapley
    # constraints must've been met, this is not guaranteed to include every
    # dish or every wine.
    #
    # @return [Hash<Object, Object>] a mapping of dish to wine pairings
    def pairings
      accepted = {}
      reversed = {}

      generator = Generator.new(match_catalog)
      decider = Decider.new(match_catalog)
      (0...match_catalog.max_dish_preferences).each do |round|
        requests = generator.requests(round, accepted)
        decider.decide!(requests, accepted, reversed)
      end

      accepted
    end

    private

    attr_reader :match_catalog
  end
  private_constant :MatchMaker
end
