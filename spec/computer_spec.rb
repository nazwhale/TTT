require 'computer'

describe Computer do

  subject(:computer) { described_class.new }

  describe '#initialize' do
    it 'has a marker' do
      expect(computer.marker).to eq Computer::MARKER
    end
  end

  describe '#choose_square' do

    it 'chooses the middle square when it is available' do
      board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
      expect(computer.choose_square(board)).to eq 4
    end

    it 'calls get_best_move if middle square is taken' do
      board = ["0", "1", "2", "3", "O", "5", "6", "7", "8"]
      expect(computer).to receive(:get_best_move).and_return 1
      computer.choose_square(board)
    end

  end

  describe '#get_best_move' do

    it 'seizes the win' do
      board = ["0", "X", "2", "O", "X", "O", "6", "7", "8"]
      expect(computer.get_best_move(board)).to eq 7
    end

    it 'prevents a loss' do
      board = ["X", "1", "2", "O", "O", "5", "6", "7", "X"]
      expect(computer.get_best_move(board)).to eq 5
    end

    it 'seizes the win, even when within one move of losing' do
      board = ["X", "X", "2", "3", "O", "O", "6", "7", "8"]
      expect(computer.get_best_move(board)).to eq 2
    end

    it 'makes a random move if no win or loss is in sight' do
      board = ["X", "O", "O", "O", "X", "X", "6", "7", "O"]
      expect(computer.get_best_move(board)).to eq(6).or(eq(7))
    end

  end

end
