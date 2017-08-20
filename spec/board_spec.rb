require 'board'

describe Board do

  subject(:board) { described_class.new }

  describe '#initialize' do
    it 'has an empty board' do
      expect(board.state).to eq Board::EMPTY_BOARD
    end
  end
end
