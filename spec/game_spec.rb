require 'game'

describe Game do

  let(:player1) { Human.new("X") }
  let(:player2) { Computer.new("O") }
  subject(:game) { described_class.new(player1, player2) }

  describe '#initialize' do
    it 'has a first player' do
      expect([Human, Computer]).to include game.player1.class
    end

    it 'has a second player' do
      expect([Human, Computer]).to include game.player2.class
    end

    it 'has a board' do
      expect(game.board).to be_a Board
    end
  end

  describe '#make_move' do
    it 'calls make_human_move for a human player' do
      allow(game).to receive(:make_human_move)
      game.make_move(player1)
      expect(game).to have_received(:make_human_move)
    end

    it 'calls make_computer_move for a computer player' do
      allow(game).to receive(:make_computer_move)
      game.make_move(player2)
      expect(game).to have_received(:make_computer_move)
    end
  end

  describe '#get_opponent' do
    it 'returns opponent' do
      expect(game.get_opponent(player1)).to eq player2
    end
  end
end
