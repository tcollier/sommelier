require_relative 'descending_insertion_sort_array'
require_relative 'preference'

class StableMarriage
  # A collection of all matches to consider for pairing up suitors and suitees.
  class MatchSet
    attr_reader :max_suitor_preferences

    def initialize
      @suitors = {}
      @suitees = {}
      @max_suitor_preferences = 0
    end

    # Add a symmetrical match for the suitor and suitee
    #
    # @param suitor [Object] the suitor
    # @param suitee [Object] the suitee
    # @param score [Number] a number dictating the strength of the match between
    #   the suitor and suitee (a higher number indicate a stronger match)
    def add(suitor, suitee, score)
      suitor_prefs = add_suitor_prefs(suitor)
      suitee_prefs = add_suitee_prefs(suitee)

      suitor_prefs.sorted_insert(Preference.new(suitee, score))
      if suitor_prefs.count > max_suitor_preferences
        @max_suitor_preferences = suitor_prefs.count
      end

      suitee_prefs.sorted_insert(Preference.new(suitor, score))
    end

    # @yield suitor, preferences_count [Object, Integer]
    def each_suitor(&block)
      suitors.each do |suitor, prefs|
        yield suitor, prefs.count
      end
    end

    # @param suitor [Object] the suitor to find the suitee for
    # @param rank [Integer] the 0-based rank in the suitor's preferences
    # @return [Object] return the Nth ranked suitee based on the given suitors
    #   preferences
    def suitee_preferred_at(suitor, rank)
      suitors[suitor][rank].object
    end

    # Return the highest ranked suitor (for the suitee) in the list of suitors
    #
    # @param suitee [Object]
    # @param suitors [Array<Object>]
    # @return [Object] the highest ranked suitor in the list
    def most_preferred(suitee, suitors)
      suitees[suitee].detect do |preference|
        suitors.include?(preference.object)
      end.object
    end

    private

    def add_suitor_prefs(object)
      suitors[object] ||= DescendingInsertionSortArray.new
      suitors[object]
    end

    def add_suitee_prefs(object)
      suitees[object] ||= DescendingInsertionSortArray.new
      suitees[object]
    end

    attr_reader :suitors, :suitees
  end
  private_constant :MatchSet
end
