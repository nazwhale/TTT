require 'human'

describe Human do

  subject(:human) { described_class.new("O") }

  describe '#initialize' do
    it 'has a symbol' do
      expect(human.symbol).to eq "O"
    end
  end
end
