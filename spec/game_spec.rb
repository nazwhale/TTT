require 'game'

describe Game do

  subject(:game) { described_class.new }

  describe '#initialize' do
    it 'has a board' do
      expect(game.board).to be_a Board
    end

    it 'has an instance of computer' do
      expect(game.computer).to be_a Computer
    end

    it 'has an instance of human' do
      expect(game.human).to be_a Human
    end
  end

  describe '#play' do
    xit 'calls board.occupied' do
      allow(game.human).to receive(:get_move).and_return("3")
      expect(game.board).to receive(:occupied?).with("3")
      game.play
    end
  end

end
