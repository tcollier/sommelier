require 'rake'
load 'tasks/sommelier.rake'

require_relative 'sommelier/match_maker'
require_relative 'sommelier/match_catalog'

# Pair off members of one set with members of another, optimizing for the total
# match score of all pairings. This is similar to how a sommelier may provide
# a complete set of wine pairings for each dish on a menu.
#
# Example:
#
#   sommelier = Sommelier.new
#   sommelier.add_match('Asparagus', 'Pinot Noir', 0.366)
#   sommelier.add_match('Asparagus', 'Sauvignon Blanc', 0.453)
#   sommelier.add_match('Asparagus', 'Chardonnay', 0.245)
#   sommelier.add_match('Tofu', 'Rosé', 0.486)
#   sommelier.add_match('Tofu', 'Sauvignon Blanc', 0.304)
#   sommelier.add_match('Eggplant', 'Sauvignon Blanc', 0.299)
#   sommelier.add_match('Salmon', 'Sauvignon Blanc', 0.602)
#   puts sommelier.pairings
#   # {
#   #   "Salmon" => "Sauvignon Blanc",
#   #   "Tofu" => "Rosé",
#   #   "Asparagus" => "Pinot Noir"
#   # }
#
#   # Note: neither "Eggplant" nor "Chardonnay" were matched in the pairings map
#
class Sommelier
  def initialize
    @match_catalog = MatchCatalog.new
  end

  # Include a potential pairing between the dish and wine. The pairing has a
  # score (a higher score means a better pairing) that is used the generate
  # preferences of dish => wines and wine => dishes. These preferences are used
  # in a variant of the Gale-Shapely algorithm.
  #
  # Since the dishes are acting as the suitors (in Gale-Shapely terminology),
  # they tend to get better preferred wines than vice versa. However, since a
  # pairing is symmetrical, passing the wines in as the dish and the dishes in
  # as the wine will work, but yield potentially different pairings.
  #
  # @param dish [Object] the proposal maker in the Gale-Shapely algorithm.
  # @param wine [Object] the proposal acceptor/rejector in the Gale-Shapely
  #   algorithm.
  # @param score [Numeric] a numeric representation of the strength of the
  #   pairing. A higher score means a better paring.
  def add_match(dish, wine, score)
    match_catalog.add(dish, wine, score)
  end

  # A map with dishes as keys and wines as objects
  #
  # @return [Hash<Object, Object>] the final matching between dishes and wines.
  def pairings
    MatchMaker.new(match_catalog).pairings
  end

  private

  attr_reader :match_catalog
end
