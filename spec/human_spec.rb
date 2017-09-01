require 'human'

describe Human do

  subject(:human) { described_class.new("O") }

  describe '#initialize' do
    it 'has a symbol' do
      expect(human.symbol).to eq "O"
    end
  end

  describe '#get_move' do
    it 'receives and returns user input' do
      allow(human).to receive(:gets).and_return('2')
      expect(human.get_move).to eq 2
    end
  end
end
