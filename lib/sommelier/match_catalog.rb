require_relative 'descending_insertion_sort_array'
require_relative 'preference'

class Sommelier
  # A collection of all matches to consider for pairing up dishes and wines.
  class MatchCatalog
    attr_reader :max_dish_preferences

    def initialize
      @dishes = {}
      @wines = {}
      @max_dish_preferences = 0
    end

    # Add a symmetrical match for the dish and wine
    #
    # @param dish [Object] the dish
    # @param wine [Object] the wine
    # @param score [Number] a number dictating the strength of the match between
    #   the dish and wine (a higher number indicate a stronger match)
    def add(dish, wine, score)
      dish_prefs = add_dish_prefs(dish)
      wine_prefs = add_wine_prefs(wine)

      dish_prefs.sorted_insert(Preference.new(wine, score))
      if dish_prefs.count > max_dish_preferences
        @max_dish_preferences = dish_prefs.count
      end

      wine_prefs.sorted_insert(Preference.new(dish, score))
    end

    # @yield dish, preferences_count [Object, Integer] yield each dish and the
    #   number of wines in it's preference list.
    def each_dish(&block)
      dishes.each do |dish, prefs|
        yield dish, prefs.count
      end
    end

    # @param dish [Object] the dish to find the wine for
    # @param rank [Integer] the 0-based rank in the dish's preferences
    # @return [Object] return the Nth ranked wine based on the given dishes
    #   preferences
    def wine_preferred_at(dish, rank)
      dishes[dish][rank].object
    end

    # Return the highest ranked dish (for the wine) in the list of dishes
    #
    # @param wine [Object]
    # @param dishes [Array<Object>]
    # @return [Object] the highest ranked dish in the list
    def most_preferred_dish(wine, dishes)
      wines[wine].detect do |preference|
        dishes.include?(preference.object)
      end.object
    end

    private

    def add_dish_prefs(object)
      dishes[object] ||= DescendingInsertionSortArray.new
      dishes[object]
    end

    def add_wine_prefs(object)
      wines[object] ||= DescendingInsertionSortArray.new
      wines[object]
    end

    attr_reader :dishes, :wines
  end
  private_constant :MatchCatalog
end
