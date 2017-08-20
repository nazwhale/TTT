require 'board'

describe Board do

  subject(:board) { described_class.new }

  describe '#initialize' do
    it 'has an empty board' do
      expect(board.state).to eq Board::EMPTY_BOARD
    end
  end

  describe '#tie' do

    context 'true' do

      it 'is a tie' do
        board.state = ["X", "X", "O", "X", "O", "O", "X", "O", "X"]
        expect(board.tie?).to be true
      end

    end

    context 'false' do

      it 'is an empty board' do
        expect(board.tie?).to be false
      end

      it 'is a win' do
        board.state = ["1", "X", "X", "O", "O", "O", "6", "7", "X"]
        expect(board.tie?).to be false
      end

      it 'is an incomplete board win no win' do
        board.state = ["X", "O", "X", "O", "X", "5", "O", "X", "O"]
        expect(board.tie?).to be false
      end

    end
  end


  describe '#game_over?' do

    context 'true' do
      context 'horizontal win' do

        it 'top row' do
          board.state = ["X", "X", "X", "O", "4", "O", "6", "7", "O"]
          expect(board.game_over?).to be true
        end

        it 'middle row' do
          board.state = ["1", "X", "X", "O", "O", "O", "6", "7", "X"]
          expect(board.game_over?).to be true
        end

        it 'bottom row' do
          board.state = ["1", "2", "3", "O", "O", "6", "X", "X", "X"]
          expect(board.game_over?).to be true
        end

      end

      context 'vertical win' do

        it 'left column' do
          board.state = ["X", "2", "3", "X", "O", "6", "X", "O", "O"]
          expect(board.game_over?).to be true
        end

        it 'middle column' do
          board.state = ["1", "X", "3", "O", "X", "6", "7", "X", "O"]
          expect(board.game_over?).to be true
        end

        it 'right column' do
          board.state = ["X", "O", "X", "O", "O", "X", "O", "X", "X"]
          expect(board.game_over?).to be true
        end

      end

      context 'diagonal win' do

        it 'bottom-left to top-right' do
          board.state = ["1", "X", "O", "X", "O", "6", "O", "8", "X"]
          expect(board.game_over?).to be true
        end

        it 'top-right to bottom-left' do
          board.state = ["X", "O", "O", "4", "X", "O", "X", "O", "X"]
          expect(board.game_over?).to be true
        end

      end

      context 'tie' do

        it 'tie' do
          board.state = ["X", "X", "O", "X", "O", "O", "X", "O", "X"]
          expect(board.game_over?).to be true
        end

      end
    end

    context 'false' do

      it 'empty board' do
        board.state = Board::EMPTY_BOARD
        expect(board.game_over?).to be false
      end

      it 'one empty square and no win' do
        board.state = ["X", "O", "X", "O", "X", "6", "O", "X", "O"]
        expect(board.game_over?).to be false
      end

    end

  end

end