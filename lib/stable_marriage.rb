require_relative 'stable_marriage/match_maker'
require_relative 'stable_marriage/match_set'

# Pair off members of one set with members of another, optimizing for the total
# match score of all proposals.
#
# Example:
#
#   sm = StableMarriage.new
#   sm.add_match('Alice', 'Marcus', 0.366)
#   sm.add_match('Alice', 'Steve', 0.453)
#   sm.add_match('Alice', 'Will', 0.245)
#   sm.add_match('Janice', 'Phil', 0.486)
#   sm.add_match('Janice', 'Steve', 0.304)
#   sm.add_match('Lily', 'Steve', 0.299)
#   sm.add_match('Maria', 'Steve', 0.602)
#   puts sm.proposals
#   # {
#   #   "Maria" => "Steve",
#   #   "Janice" => "Phil",
#   #   "Alice" => "Marcus"
#   # }
#
#   # Note: neither Lily nor Will were matched in the proposals map
#
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
