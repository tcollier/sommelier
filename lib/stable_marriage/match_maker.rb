require_relative 'match_maker/generator'
require_relative 'match_maker/decider'

class StableMarriage
  # Implementation of a variation of the Gale-Shapely algorithm. In this
  # variation, every suitor that isn't currently in a proposal and hasn't
  # exhausted his list of preferred suitees will propose the his highest
  # matching suitee that he has not yet propsed to.
  #
  # Once all of the proposals for a round are made, then suitees will accept
  # only the highest matching suitor that has proposed to her. She will reject
  # all others, even if she had previously accepted his proposal.
  class MatchMaker
    def initialize(match_set)
      @match_set = match_set
    end

    # Return a set of proposals. Given that not allowed all of the Gale-Shapely
    # constraints must've been met, this is not guaranteed to include every
    # suitor or every suitee.
    #
    # @return [Hash<Object, Object>] a mapping of suitor to suitee proposals
    def proposals
      accepted = {}
      reversed = {}

      generator = Generator.new(match_set)
      decider = Decider.new(match_set)
      (0...match_set.max_suitor_preferences).each do |round|
        provisional = generator.proposals(round, accepted)
        decider.decide!(provisional, accepted, reversed)
      end

      accepted
    end

    private

    attr_reader :match_set
  end
  private_constant :MatchMaker
end
