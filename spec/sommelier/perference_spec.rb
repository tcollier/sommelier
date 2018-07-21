require 'sommelier/preference'

class Sommelier
  describe Preference do
    describe '#>' do
      subject(:preference) { described_class.new('Foo', 10) }

      context 'when subject has greater score than other' do
        let(:other) { described_class.new('Bar', 9) }

        specify do
          expect(preference > other).to eq(true)
        end
      end

      context 'when subject has score equal to other' do
        let(:other) { described_class.new('Bar', 10) }

        specify do
          expect(preference > other).to eq(false)
        end
      end

      context 'when subject has lesser score than other' do
        let(:other) { described_class.new('Bar', 11) }

        specify do
          expect(preference > other).to eq(false)
        end
      end
    end
  end
end
