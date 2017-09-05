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

    before do
      game.current_player = player1
    end

    context 'game not over' do
      it 'shows the board state before each move' do
        allow(game.board).to receive(:game_over?).and_return(false, true)
        allow(game).to receive(:show_current_board)
        allow(game).to receive(:make_move)
        allow(game).to receive(:game_over_message)
        game.play
        expect(game).to have_received(:make_move)
      end

      it 'calls make_move for each player' do
        allow(game.board).to receive(:game_over?).and_return(false, false, true)
        allow(game).to receive(:show_current_board)
        allow(game).to receive(:make_move)
        allow(game).to receive(:game_over_message)
        game.play
        expect(game).to have_received(:make_move).twice
      end

      it 'switches player after a move' do
        allow(game.board).to receive(:game_over?).and_return(false, true)
        allow(game).to receive(:show_current_board)
        allow(game).to receive(:make_move)
        allow(game).to receive(:game_over_message)
        game.play
        expect(game.current_player).to eq player2
      end

      it 'switches back to the first player after 2 moves' do
        allow(game.board).to receive(:game_over?).and_return(false, false, true)
        allow(game).to receive(:show_current_board)
        allow(game).to receive(:make_move)
        allow(game).to receive(:game_over_message)
        game.play
        expect(game.current_player).to eq player1
      end
    end

    context 'game over' do
      it 'shows the final state of the board' do
        allow(game.board).to receive(:game_over?).and_return(true)
        allow(game).to receive(:show_current_board)
        allow(game).to receive(:game_over_message)
        game.play
        expect(game).to have_received(:show_current_board)
      end

      it 'calls game_over_message' do
        allow(game.board).to receive(:game_over?).and_return(true)
        allow(game).to receive(:show_current_board)
        allow(game).to receive(:game_over_message)
        game.play
        expect(game).to have_received(:game_over_message)
      end
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

  describe '#human_player?' do
    it 'returns true for a human' do
      expect(game.human_player?(player1)).to eq true
    end

    it 'returns false for a computer' do
      expect(game.human_player?(player2)).to eq false
    end
  end

  describe '#make_human_move' do
    context 'valid input' do
      it 'places a symbol for the chosen move' do
        allow(game).to receive(:gets).and_return("2")
        game.make_human_move(player1)
        expect(game.board.state).to eq ["0", "1", "X", "3", "4", "5", "6", "7", "8"]
      end
    end

    context 'invalid input' do
      it 'outputs error if move is an integer above the maximum board index' do
        allow(Messages).to receive(:prompt_move)
        allow(Messages).to receive(:human_move_confirmation)
        allow(game).to receive(:gets).and_return("9", "3")
        message = "Please choose one of the available squares!\n"
        expect{ game.make_human_move(player1) }.to output(message).to_stdout
      end

      it 'outputs error if input is empty' do
        allow(Messages).to receive(:prompt_move)
        allow(Messages).to receive(:human_move_confirmation)
        allow(game).to receive(:gets).and_return("", "4")
        message = "Please choose one of the available squares!\n"
        expect{ game.make_human_move(player1) }.to output(message).to_stdout
      end

      it 'outputs error if input is not an integer' do
        allow(Messages).to receive(:prompt_move)
        allow(Messages).to receive(:human_move_confirmation)
        allow(game).to receive(:gets).and_return("Not An Integer", "5")
        message = "Please choose one of the available squares!\n"
        expect{ game.make_human_move(player1) }.to output(message).to_stdout
      end
    end
  end

  describe '#get_opponent' do
    it 'returns opponent' do
      expect(game.get_opponent(player1)).to eq player2
    end
  end

end
