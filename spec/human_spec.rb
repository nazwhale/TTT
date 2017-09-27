require 'human'

describe Human do

  subject(:human) { described_class.new("O") }

  describe '#initialize' do
    it 'has a symbol' do
      expect(human.symbol).to eq "O"
    end
  end

  describe '#get_move' do
    it 'allows user input' do
      board = instance_double("Board", :state => ['0', '1', '2', '3', '4', '5', '6', '7', '8'])
      game = instance_double("Game", :board => board)
      allow(human).to receive(:gets).and_return('1')
      allow(board).to receive(:occupied?).and_return(false)
      expect(human.get_move(game)).to eq 1
    end

    it 'rejects an empty string' do
      board = instance_double("Board", :state => ['0', '1', '2', '3', '4', '5', '6', '7', '8'])
      game = instance_double("Game", :board => board)
      allow(human).to receive(:gets).and_return('', '1')
      allow(board).to receive(:occupied?).and_return(false)
      human.get_move(game)
      expect(human).to have_received(:gets).twice
    end

    it 'rejects an occupied square' do
      board = instance_double("Board", :state => ['0', 'X', '2', '3', '4', '5', '6', '7', '8'])
      game = instance_double("Game", :board => board)
      allow(human).to receive(:gets).and_return('1', '2')
      allow(board).to receive(:occupied?).and_return(true, false)
      human.get_move(game)
      expect(human).to have_received(:gets).twice
    end
  end
end

