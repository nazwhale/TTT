require 'game'

describe Game do

  subject(:game) { described_class.new("player1", "player2") }

  describe '#initialize' do
    it 'has a board' do
      expect(game.board).to be_a Board
    end

  end

end
