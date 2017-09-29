require 'board'

describe Board do

  let(:player1) { Human.new("X") }
  let(:player2) { Computer.new("O") }
  subject(:board) { described_class.new(3) }

  describe '#occupied?' do
    before do
      board.state = ["X", "N", "O", "X", nil, "O", "X", "O", "X"]
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
      board.state = ["X", nil, nil, nil, nil, nil, nil, nil, nil]
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
        board.state = [nil, "X", "X", "O", "O", "O", nil, nil, "X"]
        expect(board.game_over?(player1, player2)).to be true
      end
    end

    context 'false' do
      it 'has unoccupied squares and no win' do
        board.state = ["X", "O", "X", "O", "X", nil, "O", "X", "O"]
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
        board.state = [nil, "X", "X", "O", "O", "O", nil, nil, "X"]
        expect(board.tie?(player1, player2)).to be false
      end

      it 'has unoccupied squares with no win' do
        board.state = ["X", "O", "X", "O", "X", nil, "O", "X", "O"]
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
          board.state = ["X", "X", "X", "O", nil, "O", nil, nil, "O"]
          expect(board.win?(player1)).to be true
        end

        it 'middle row' do
          board.state = [nil, "X", "X", "O", "O", "O", nil, nil, "X"]
          expect(board.win?(player2)).to be true
        end

        it 'bottom row' do
          board.state = [nil, nil, nil, "O", "O", nil, "X", "X", "X"]
          expect(board.win?(player1)).to be true
        end
      end

      context 'vertical win' do
        it 'left column' do
          board.state = ["X", nil, nil, "X", "O", nil, "X", "O", "O"]
          expect(board.win?(player1)).to be true
        end

        it 'middle column' do
          board.state = [nil, "X", nil, "O", "X", nil, nil, "X", "O"]
          expect(board.win?(player1)).to be true
        end

        it 'right column' do
          board.state = ["X", "O", "X", "O", "O", "X", "O", "X", "X"]
          expect(board.win?(player1)).to be true
        end
      end

      context 'diagonal win' do
        it 'bottom-left to top-right' do
          board.state = [nil, "X", "O", "X", "O", nil, "O", nil, "X"]
          expect(board.win?(player2)).to be true
        end

        it 'top-right to bottom-left' do
          board.state = ["X", "O", "O", nil, "X", "O", "X", "O", "X"]
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
        board.state = [nil, nil, nil, nil, nil, nil, nil, nil, nil]
        expect(board.win?(player1)).to be false
      end

      it 'one unoccupied square and no win' do
        board.state = ["X", "O", "X", "O", "X", nil, "O", "X", "O"]
        expect(board.win?(player1)).to be false
      end
    end
  end
end
