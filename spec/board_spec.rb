require 'board'

describe Board do

  let(:player1) { Human.new("X") }
  let(:player2) { Computer.new("O") }
  subject(:board) { described_class.new }

  describe '#initialize' do
    it 'has an empty board' do
      expect(board.state).to eq Board::EMPTY_BOARD
    end
  end

  describe '#occupied?' do
    before do
      board.state = ["X", "N", "O", "X", "4", "O", "X", "O", "X"]
    end

    context 'true' do
      it 'is occupied by a X' do
        expect(board.occupied?(3)).to be true
      end

      it 'is occupied by a symbol other than X or O' do
        expect(board.occupied?(1)).to be true
      end
    end

    context 'false' do
      it 'is unoccupied' do
        expect(board.occupied?(4)).to be false
      end
    end
  end

  describe '#empty?' do
    it 'is empty' do
      expect(board.empty?).to be true
    end

    it 'is not empty' do
      board.state = ["X", "N", "O", "X", "4", "O", "X", "O", "X"]
      expect(board.empty?).to be false
    end
  end

  describe '#game_over' do
    context 'true' do
      it 'is a tie' do
        board.state = ["X", "X", "O", "X", "O", "O", "X", "O", "X"]
        expect(board.game_over?(player1, player2)).to be true
      end

      it 'is won' do
        board.state = ["1", "X", "X", "O", "O", "O", "6", "7", "X"]
        expect(board.game_over?(player1, player2)).to be true
      end
    end

    context 'false' do
      it 'has unoccupied squares and no win' do
        board.state = ["X", "O", "X", "O", "X", "5", "O", "X", "O"]
        expect(board.game_over?(player1, player2)).to be false
      end
    end
  end

  describe '#tie' do
    context 'true' do
      it 'is a tie' do
        board.state = ["O", "X", "O", "X", "O", "O", "X", "O", "X"]
        expect(board.tie?(player1, player2)).to be true
      end
    end

    context 'false' do
      it 'is an empty board' do
        expect(board.tie?(player1, player2)).to be false
      end

      it 'is a win' do
        board.state = ["1", "X", "X", "O", "O", "O", "6", "7", "X"]
        expect(board.tie?(player1, player2)).to be false
      end

      it 'has unoccupied squares with no win' do
        board.state = ["X", "O", "X", "O", "X", "5", "O", "X", "O"]
        expect(board.tie?(player1, player2)).to be false
      end

      it 'is fully occupied with a win' do
        board.state = ["X", "X", "X", "O", "O", "X", "O", "X", "O"]
        expect(board.tie?(player1, player2)).to be false
      end
    end
  end

  describe '#win?' do
    context 'true' do
      context 'horizontal win' do
        it 'top row' do
          board.state = ["X", "X", "X", "O", "4", "O", "6", "7", "O"]
          expect(board.win?(player1)).to be true
        end

        it 'middle row' do
          board.state = ["1", "X", "X", "O", "O", "O", "6", "7", "X"]
          expect(board.win?(player2)).to be true
        end

        it 'bottom row' do
          board.state = ["1", "2", "3", "O", "O", "6", "X", "X", "X"]
          expect(board.win?(player1)).to be true
        end
      end

      context 'vertical win' do
        it 'left column' do
          board.state = ["X", "2", "3", "X", "O", "6", "X", "O", "O"]
          expect(board.win?(player1)).to be true
        end

        it 'middle column' do
          board.state = ["1", "X", "3", "O", "X", "6", "7", "X", "O"]
          expect(board.win?(player1)).to be true
        end

        it 'right column' do
          board.state = ["X", "O", "X", "O", "O", "X", "O", "X", "X"]
          expect(board.win?(player1)).to be true
        end
      end

      context 'diagonal win' do
        it 'bottom-left to top-right' do
          board.state = ["1", "X", "O", "X", "O", "6", "O", "8", "X"]
          expect(board.win?(player2)).to be true
        end

        it 'top-right to bottom-left' do
          board.state = ["X", "O", "O", "4", "X", "O", "X", "O", "X"]
          expect(board.win?(player1)).to be true
        end
      end

      context 'tie' do
        it 'tie' do
          board.state = ["O", "X", "O", "X", "O", "O", "X", "O", "X"]
          expect(board.win?(player1)).to be false
        end
      end
    end

    context 'false' do
      it 'empty board' do
        board.state = Board::EMPTY_BOARD
        expect(board.win?(player1)).to be false
      end

      it 'one unoccupied square and no win' do
        board.state = ["X", "O", "X", "O", "X", "6", "O", "X", "O"]
        expect(board.win?(player1)).to be false
      end
    end
  end

  describe '#get_corners' do
    it 'returns an array of corner indexes' do
      expect(board.get_corners).to eq Board::CORNERS
    end
  end
end
