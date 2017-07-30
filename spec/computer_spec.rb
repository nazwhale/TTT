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

  end

end
