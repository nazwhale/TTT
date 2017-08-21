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
    it 'calls show_current_board' do
      allow(game.human).to receive(get_move) { "2" }
      expect(game).to receive(:show_current_board)
      game.play
    end
  end

end
