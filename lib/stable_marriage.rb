require_relative 'stable_marriage/match_maker'
require_relative 'stable_marriage/match_set'

class StableMarriage
  def initialize
    @match_set = MatchSet.new
  end

  # The the matching between the suitor and suitee with the match score.
  #
  # @param suitor [Object] the proposal maker in the Gale-Shapely algorithm.
  #   This party tends to fare better than the suitee in the algorithm.
  # @param suitee [Object] the proposal acceptor/rejector in the Gale-Shapely
  #   algorithm.
  # @param score [Numeric] a numeric representation of the strength of the
  #   match. A higher score means a better match.
  def add_match(suitor, suitee, score)
    match_set.add(suitor, suitee, score)
  end

  # A map with suitors as keys and suitees as objects
  #
  # @return [Hash<Object, Object>] the final matching between suitors and
  #   suitees.
  def proposals
    MatchMaker.new(match_set).proposals
  end

  private

  attr_reader :match_set
end
