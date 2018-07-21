require 'sommelier'

describe 'full preferences solution' do
  subject(:sommelier) { Sommelier.new }

  before do
    sommelier.add_match('Asparagus', 'Sauvignon Blanc', 1)
    sommelier.add_match('Asparagus', 'Pinot Noir', 5)
    sommelier.add_match('Asparagus', 'Rosé', 8)
    sommelier.add_match('Tofu', 'Sauvignon Blanc', 2)
    sommelier.add_match('Tofu', 'Pinot Noir', 3)
    sommelier.add_match('Tofu', 'Rosé', 9)
    sommelier.add_match('Salmon', 'Sauvignon Blanc', 7)
    sommelier.add_match('Salmon', 'Pinot Noir', 6)
    sommelier.add_match('Salmon', 'Rosé', 4)
  end

  it 'includes a complete pairing for all dishes and wines' do
    pairings = sommelier.pairings
    expect(pairings.length).to eq(3)
    expect(pairings).to have_key('Asparagus')
    expect(pairings).to have_key('Tofu')
    expect(pairings).to have_key('Salmon')
    expect(pairings['Asparagus']).to eq('Pinot Noir')
    expect(pairings['Tofu']).to eq('Rosé')
    expect(pairings['Salmon']).to eq('Sauvignon Blanc')
  end
end
