class Sommelier
  # Simple class to bind a score (useable for ranking/sorting) to a generic
  # object.
  class Preference
    attr_reader :object, :score

    def initialize(object, score)
      @object = object
      @score = score
    end

    # Items used in DescendingInsertionSortArray must implement `>`
    def >(other)
      score > other.score
    end
  end
  private_constant :Preference
end
