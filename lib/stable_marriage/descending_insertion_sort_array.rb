class StableMarriage
  class DescendingInsertionSortArray < Array
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
