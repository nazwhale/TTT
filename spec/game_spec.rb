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

  describe '#play' do
    context 'game not over' do
      it 'shows the board state before each move' do
        allow(game.board).to receive(:game_over?).and_return(false, true)
        allow(game).to receive(:show_current_board)
        allow(game).to receive(:make_move)
        allow(game).to receive(:show_game_over)
        game.play
        expect(game).to have_received(:make_move)
      end

      it 'calls make_move for each player' do
        allow(game.board).to receive(:game_over?).and_return(false, false, true)
        allow(game).to receive(:show_current_board)
        allow(game).to receive(:make_move)
        allow(game).to receive(:show_game_over)
        game.play
        expect(game).to have_received(:make_move).twice
      end

      it 'switches player after a move' do
        allow(game.board).to receive(:game_over?).and_return(false, true)
        allow(game).to receive(:show_current_board)
        allow(game).to receive(:make_move)
        allow(game).to receive(:show_game_over)
        game.play
        expect(game.current_player).to eq player2
      end

      it 'switches back to the first player after 2 moves' do
        allow(game.board).to receive(:game_over?).and_return(false, false, true)
        allow(game).to receive(:show_current_board)
        allow(game).to receive(:make_move)
        allow(game).to receive(:show_game_over)
        game.play
        expect(game.current_player).to eq player1
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
