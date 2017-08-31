require 'computer'

describe Computer do

  subject(:computer) { described_class.new("X") }
  let(:board) { Board.new }

  describe '#initialize' do
    it 'has a symbol' do
      expect(computer.symbol).to eq "X"
    end
  end

  describe '#get_move' do

    it 'gets the middle square when it is available' do
      board.state = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
      expect(computer.get_move(board)).to eq 4
    end

    it 'calls get_best_move if middle square is taken' do
      board.state = ["0", "1", "2", "3", "O", "5", "6", "7", "8"]
      expect(computer).to receive(:get_best_move).and_return 1
      computer.get_move(board)
    end

  end

  describe '#get_best_move' do

    it 'seizes the win' do
      board.state = ["0", "X", "2", "O", "X", "O", "6", "7", "8"]
      expect(computer.get_best_move(board)).to eq 7
    end

    it 'prevents a loss' do
      board.state = ["X", "1", "2", "O", "O", "5", "6", "7", "X"]
      expect(computer.get_best_move(board)).to eq 5
    end

    it 'seizes the win, even when within one move of losing' do
      board.state = ["X", "X", "2", "3", "O", "O", "6", "7", "8"]
      expect(computer.get_best_move(board)).to eq 2
    end

    it 'makes a random move if no win or loss is in sight' do
      board.state = ["X", "O", "O", "O", "X", "X", "6", "7", "O"]
      expect(computer.get_best_move(board)).to eq(6).or(eq(7))
    end

  end

end
