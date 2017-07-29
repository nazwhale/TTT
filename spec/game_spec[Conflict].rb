require 'game'

describe Game do

  let(:game) { described_class.new }

  describe '#initialize' do
    it 'has a board' do
      expect(game.board).to eq Game::BOARD
    end

    it 'has a computer player with an marker' do
      expect(game.computer).to eq Game::COMPUTER_MARKER
    end

    it 'has a human player with an marker' do
      expect(game.human).to eq Game::HUMAN_MARKER
    end
  end

  describe '#game_is_over' do

    context 'true' do

      context 'horizontal win' do

        it 'is a first column horizontal win' do
          board = ["X", "X", "X", "O", "4", "O", "6", "7", "O"]
          expect(game.game_is_over(board)).to be true
        end

      end

    end
  end

end
