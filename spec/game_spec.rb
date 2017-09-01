require 'game'

describe Game do

  let(:player1) { Human.new("X") }
  let(:player2) { Computer.new("O") }
  let(:board) { Board.new }
  subject(:game) { described_class.new(player1, player2, board) }

  describe '#initialize' do
    it 'has a board' do
      expect(game.board).to be_a Board
    end
  end

  describe '#play' do
    context 'game not over' do
      it 'shows the board state before each move' do
        allow(game.board).to receive(:game_over?).and_return(false, true)
        allow(game).to receive(:show_current_board)
        allow(game).to receive(:make_move)
        game.play
        expect(game).to have_received(:make_move).twice
      end

      it 'calls make_move for each player' do
        allow(game.board).to receive(:game_over?).and_return(false, true)
        allow(game).to receive(:show_current_board)
        allow(game).to receive(:make_move)
        game.play
        expect(game).to have_received(:make_move).twice
      end
    end

    context 'game over' do
      it 'shows the final state of the board' do
        allow(game.board).to receive(:game_over?).and_return(true)
        allow(game).to receive(:show_current_board)
        allow(game).to receive(:show_game_over)
        game.play
        expect(game).to have_received(:show_current_board)
      end

      it 'calls show_game_over' do
        allow(game.board).to receive(:game_over?).and_return(true)
        allow(game).to receive(:show_current_board)
        allow(game).to receive(:show_game_over)
        game.play
        expect(game).to have_received(:show_game_over)
      end
    end
  end

end
