require 'computer'

describe Computer do

  subject(:computer) { described_class.new }

  describe '#initialize' do
    it 'has a marker' do
      expect(computer.marker).to eq Computer::MARKER
    end
  end

  describe '#get_computer_square' do

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

end
