require 'game'

describe Game do

  let(:player1) { Human.new("X") }
  let(:player2) { Computer.new("O") }
  let(:board) { Board.new(3) }
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
    it 'calls make_move for a computer player' do
      allow(player2).to receive(:get_move)
      game.make_move(player2)
      expect(player2).to have_received(:get_move)
    end
  end

  describe '#get_opponent' do
    it 'returns opponent' do
      expect(game.get_opponent(player1)).to eq player2
    end
  end

  describe '#game_over?' do
    it 'calls game.over method in board' do
      game.instance_variable_set(:@board, board)
      allow(board).to receive(:game_over?)
      game.game_over?
      expect(board).to have_received(:game_over?)
    end
  end

  describe '#tie?' do
    it 'returns opponent' do
      game.instance_variable_set(:@board, board)
      allow(board).to receive(:tie?)
      game.tie?
      expect(board).to have_received(:tie?)
    end
  end
end
