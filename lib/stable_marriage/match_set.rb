require_relative 'descending_insertion_sort_array'
require_relative 'preference'

class StableMarriage
  class MatchSet
    attr_reader :max_suitor_preferences

    def initialize
      @suitors = {}
      @suitees = {}
      @max_suitor_preferences = 0
    end

    def add(suitor, suitee, score)
      suitor_prefs = add_suitor_prefs(suitor)
      suitee_prefs = add_suitee_prefs(suitee)

      suitor_prefs.sorted_insert(Preference.new(suitee, score))
      if suitor_prefs.count > max_suitor_preferences
        @max_suitor_preferences = suitor_prefs.count
      end

      suitee_prefs.sorted_insert(Preference.new(suitor, score))
    end

    def each_suitor_prefs(&block)
      suitors.each(&block)
    end

    def suitee_preferred_at(suitor, round)
      suitors[suitor][round].object
    end

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
