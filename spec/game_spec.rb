require 'game'

describe Game do

  let(:game) { described_class.new }

  describe '#initialize' do
    it 'has a board' do
      test_board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
      expect(game.board).to eq test_board
    end

    it 'has a computer player with an emblem' do
      computer_emblem = "X"
      expect(game.computer).to eq computer_emblem
    end

    it 'has a human player with an emblem' do
      human_emblem = "O"
      expect(game.human).to eq human_emblem
    end
  end

end
