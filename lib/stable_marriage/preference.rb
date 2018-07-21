class StableMarriage
  class Preference
    attr_reader :object, :score

    def initialize(object, score)
      @object = object
      @score = score
    end

    def hash
      object.hash
    end

    def ==(other)
      return false unless other.is_a?(self.class)
      hash == other.hash
    end
    alias_method :eql?, :==

    # Items used in DescendingInsertionSortArray must implement `>`
    def >(other)
      score > other.score
    end
  end

  private_constant :Preference
end
