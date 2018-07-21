class StableMarriage
  # An extension of the ruby built-in Array class with an optimization for
  # insertion sort. This class assumes the array elements are sorted in
  # descending order.
  class DescendingInsertionSortArray < Array
    # Insert `item` just before the element with the highest value that is lower
    # than the value of `item`
    #
    # @param item [Object] any object that responds to `>`
    def sorted_insert(item)
      insertion_index = (0...size).bsearch(&search_proc(item))
      insert(insertion_index || length, item)
    end

    private

    def search_proc(item)
      ->(index) { item > self[index] }
    end
  end
  private_constant :DescendingInsertionSortArray
end
