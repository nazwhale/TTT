require 'game'

describe Game do

  subject(:game) { described_class.new }

  describe '#initialize' do
    it 'has a board' do
      expect(game.board).to eq Game::EMPTY_BOARD
    end

    it 'has a computer player with an marker' do
      expect(game.computer).to eq Game::COMPUTER_MARKER
    end

    it 'has a human player with an marker' do
      expect(game.human).to eq Game::HUMAN_MARKER
    end
  end

  describe '#get_computer_square' do

    it 'chooses the middle square when it is available' do
      game.get_computer_square
      expect(game.board[4]).to eq Game::COMPUTER_MARKER
    end

    it 'calls get_best_move if middle square is taken' do
      game.board = ["0", "1", "2", "3", "O", "5", "6", "7", "8"]
      expect(game).to receive(:get_best_move).and_return 1
      game.get_computer_square
    end

  end

  describe '#tie' do

    context 'true' do

      it 'is a tie' do
        board = ["X", "X", "O", "X", "O", "O", "X", "O", "X"]
        expect(game.tie(board)).to be true
      end

    end

    context 'false' do

      it 'is an empty board' do
        board = Game::EMPTY_BOARD
        expect(game.tie(board)).to be false
      end

      it 'is a win' do
        board = ["1", "X", "X", "O", "O", "O", "6", "7", "X"]
        expect(game.tie(board)).to be false
      end

      it 'is an incomplete board win no win' do
        board = ["X", "O", "X", "O", "X", "5", "O", "X", "O"]
        expect(game.tie(board)).to be false
      end

    end
  end

  describe '#game_is_over' do

    context 'true' do
      context 'horizontal win' do

        it 'top row' do
          board = ["X", "X", "X", "O", "4", "O", "6", "7", "O"]
          expect(game.game_is_over(board)).to be true
        end

        it 'middle row' do
          board = ["1", "X", "X", "O", "O", "O", "6", "7", "X"]
          expect(game.game_is_over(board)).to be true
        end

        it 'bottom row' do
          board = ["1", "2", "3", "O", "O", "6", "X", "X", "X"]
          expect(game.game_is_over(board)).to be true
        end

      end

      context 'vertical win' do

        it 'left column' do
          board = ["X", "2", "3", "X", "O", "6", "X", "O", "O"]
          expect(game.game_is_over(board)).to be true
        end

        it 'middle column' do
          board = ["1", "X", "3", "O", "X", "6", "7", "X", "O"]
          expect(game.game_is_over(board)).to be true
        end

        it 'right column' do
          board = ["X", "O", "X", "O", "O", "X", "O", "X", "X"]
          expect(game.game_is_over(board)).to be true
        end

      end

      context 'diagonal win' do

        it 'bottom-left to top-right' do
          board = ["1", "X", "O", "X", "O", "6", "O", "8", "X"]
          expect(game.game_is_over(board)).to be true
        end

        it 'top-right to bottom-left' do
          board = ["X", "O", "O", "4", "X", "O", "X", "O", "X"]
          expect(game.game_is_over(board)).to be true
        end

      end

      context 'tie' do

        it 'tie' do
          board = ["X", "X", "O", "X", "O", "O", "X", "O", "X"]
          expect(game.game_is_over(board)).to be true
        end

      end
    end

    context 'false' do

      it 'empty board' do
        board = Game::EMPTY_BOARD
        expect(game.game_is_over(board)).to be false
      end

      it 'one empty square and no win' do
        board = ["X", "O", "X", "O", "X", "6", "O", "X", "O"]
        expect(game.game_is_over(board)).to be false
      end

    end

  end

end
