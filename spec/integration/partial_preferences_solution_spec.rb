require 'sommelier'

describe 'partial preferences solution' do
  subject(:sommelier) { Sommelier.new }

  before do
    sommelier.add_match('Asparagus', 'Pinot Noir', 0.366)
    sommelier.add_match('Asparagus', 'Sauvignon Blanc', 0.453)
    sommelier.add_match('Asparagus', 'Chardonnay', 0.245)
    sommelier.add_match('Tofu', 'Rosé', 0.486)
    sommelier.add_match('Tofu', 'Sauvignon Blanc', 0.304)
    sommelier.add_match('Eggplant', 'Sauvignon Blanc', 0.299)
    sommelier.add_match('Salmon', 'Sauvignon Blanc', 0.602)
  end

  it 'includes a pairing for some dishes and wines' do
    pairings = sommelier.pairings
    expect(pairings.length).to eq(3)
    expect(pairings).to have_key('Salmon')
    expect(pairings).to have_key('Tofu')
    expect(pairings).to have_key('Asparagus')
    expect(pairings['Salmon']).to eq('Sauvignon Blanc')
    expect(pairings['Tofu']).to eq('Rosé')
    expect(pairings['Asparagus']).to eq('Pinot Noir')
  end
end
