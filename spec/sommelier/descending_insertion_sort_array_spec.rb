require 'sommelier/descending_insertion_sort_array'

class Sommelier
  describe DescendingInsertionSortArray do
    describe '#sorted_insert' do
      subject(:array) { described_class.new }

      it 'inserts an element' do
        expect do
          array.sorted_insert(5)
        end.to change(array, :count).from(0).to(1)
        expect(array[0]).to eq(5)
      end

      context 'when a higher ranked item is added' do
        subject(:array) { described_class.new([5]) }

        it 'inserts it before the existing element' do
          expect do
            array.sorted_insert(10)
          end.to change(array, :count).from(1).to(2)
          expect(array[0]).to eq(10)
          expect(array[1]).to eq(5)
        end
      end

      context 'when a lower ranked item is added' do
        subject(:array) { described_class.new([5]) }

        it 'inserts it before the existing element' do
          expect do
            array.sorted_insert(3)
          end.to change(array, :count).from(1).to(2)
          expect(array[0]).to eq(5)
          expect(array[1]).to eq(3)
        end
      end

    end
  end
end
