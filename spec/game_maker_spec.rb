require 'game_maker'

describe GameMaker do

  let(:ui) { UI.new }
  let(:player1) { Human.new("X") }
  let(:player2) { Computer.new("O") }
  let(:game) { Game.new(player1, player2) }
  subject(:game_maker) { described_class.new(ui)}

  describe '#new_game' do
    before do
      game_maker.instance_variable_set(:@ui, ui)
      game_maker.instance_variable_set(:@game, game)
      allow(ui).to receive(:welcome)
      allow(ui).to receive(:choose_player1_symbol)
      allow(ui).to receive(:choose_player2_symbol)
      allow(ui).to receive(:ready_to_play)
      allow(ui).to receive(:game_type_confirmation)
      allow(ui).to receive(:print_board)
      allow(ui).to receive(:see_you_again)
      allow(ui).to receive(:tie_message)
      allow(ui).to receive(:win_message)
      allow(game_maker).to receive(:get_symbol)
      allow(game_maker).to receive(:choose_game_type)
      allow(game_maker).to receive(:choose_starting_player)
      allow(game_maker).to receive(:game_cycle)
      game_maker.new_game
    end

    it 'calls get_symbol twice' do
      expect(game_maker).to have_received(:get_symbol).twice
    end

    it 'calls choose_game_type' do
      expect(game_maker).to have_received(:choose_game_type).once
    end

    it 'calls choose_starting_player' do
      expect(game_maker).to have_received(:choose_starting_player).once
    end
  end

  describe '#game_cycle' do
    before do
      game.current_player = player1
      allow(ui).to receive(:print_board)
      allow(ui).to receive(:prompt_move)
      allow(ui).to receive(:computer_thinking)
      allow(ui).to receive(:choice_confirmation)
      allow(ui).to receive(:computer_move_confirmation)
      game_maker.instance_variable_set(:@game, game)
      allow(game).to receive(:make_move).and_return(0, 1, 3)
    end

    context 'game not over' do
      it 'shows the board state before each move' do
        allow(game).to receive(:game_over?).and_return(false, true)
        game_maker.game_cycle
        expect(game_maker.game).to have_received(:make_move)
      end

      it 'calls make_move for each player' do
        allow(game).to receive(:game_over?).and_return(false, false, true)
        game_maker.game_cycle
        expect(game).to have_received(:make_move).twice
      end

      it 'switches player after a move' do
        allow(game).to receive(:game_over?).and_return(false, true)
        game_maker.game_cycle
        expect(game.current_player).to eq player2
      end

      it 'switches back to the first player after 2 moves' do
        allow(game).to receive(:game_over?).and_return(false, false, true)
        game_maker.game_cycle
        expect(game.current_player).to eq player1
      end
    end

    context 'game over' do
      it 'does not make another move' do
        allow(game).to receive(:game_over?).and_return(true)
        game_maker.game_cycle
        expect(game).not_to have_received(:make_move)
      end
    end
  end

  describe '#choose_game_type' do
    before do
      allow(ui).to receive(:prompt_game_type)
    end

    context '#human_vs_human' do
      it 'chooses two human players' do
        allow(game_maker).to receive(:gets).and_return('1')
        allow(game_maker).to receive(:human_vs_human)
        game_maker.choose_game_type("X", "O")
        expect(game_maker).to have_received(:human_vs_human)
      end

      it 'makes a game with two instances of Human' do
        game_maker.human_vs_human("X", "O")
        expect(game_maker.game.player1).to be_a Human
        expect(game_maker.game.player2).to be_a Human
      end
    end

    context '#human_vs_computer' do
      it 'chooses human vs computer' do
        allow(game_maker).to receive(:gets).and_return('2')
        allow(game_maker).to receive(:human_vs_computer)
        game_maker.choose_game_type("X", "O")
        expect(game_maker).to have_received(:human_vs_computer)
      end

      it 'makes a game with one human and one computer' do
        game_maker.human_vs_computer("X", "O")
        expect(game_maker.game.player1).to be_a Human
        expect(game_maker.game.player2).to be_a Computer
      end
    end

    context '#computer_vs_computer' do
      it 'chooses two computer players' do
        allow(game_maker).to receive(:gets).and_return('3')
        allow(game_maker).to receive(:computer_vs_computer)
        game_maker.choose_game_type("X", "O")
        expect(game_maker).to have_received(:computer_vs_computer)
      end

      it 'makes a game with two instances of computer' do
        game_maker.computer_vs_computer("X", "O")
        expect(game_maker.game.player1).to be_a Computer
        expect(game_maker.game.player2).to be_a Computer
      end
    end

    context 'invalid input' do
      it 'calls try again message if invalid input' do
        allow(game_maker).to receive(:gets).and_return('4', '1')
        allow(game_maker).to receive(:human_vs_human)
        allow(ui).to receive(:try_again)
        game_maker.choose_game_type("X", "O")
        expect(ui).to have_received(:try_again).once
      end
    end
  end

  describe '#get_symbol' do
    before do
      allow(ui).to receive(:choose_player1_symbol)
      allow(ui).to receive(:choose_player2_symbol)
    end

    context 'valid' do
      it 'accepts a unique 1 character symbol' do
        allow(game_maker).to receive(:gets).and_return('X')
        message = "You chose: X\n\n"
        expect{ game_maker.get_symbol(2, 'O') }.to output(message).to_stdout
      end
    end

    context 'invalid' do
      it 'outputs an error if symbol is more than 1 character' do
        allow(game_maker).to receive(:gets).and_return('LONG SYMBOL', 'X')
        message = "Symbol must be 1 character long! Please try again.\nYou chose: X\n\n"
        expect{ game_maker.get_symbol(1, nil) }.to output(message).to_stdout
      end

      it 'outputs an error if symbol is blank' do
        allow(game_maker).to receive(:gets).and_return('', 'X')
        message = "Symbol must be 1 character long! Please try again.\nYou chose: X\n\n"
        expect{ game_maker.get_symbol(1, nil) }.to output(message).to_stdout
      end

      it 'outputs an error if symbol is an integer' do
        allow(game_maker).to receive(:gets).and_return("6", 'X')
        message = "Symbol cannot be an integer! Please try again.\nYou chose: X\n\n"
        expect{ game_maker.get_symbol(1, nil) }.to output(message).to_stdout
      end

      it 'outputs an error if symbol is the same as the opponent' do
        allow(game_maker).to receive(:gets).and_return('O', 'X')
        message = "Choose a different symbol to player 1!\nYou chose: X\n\n"
        expect{ game_maker.get_symbol(2, 'O') }.to output(message).to_stdout
      end
    end
  end

  describe '#choose_starting_player' do
    before do
      game_maker.game = game
      allow(ui).to receive(:choose_starting_player)
    end

    context 'valid input' do
      it 'sets current player to 1 if chosen' do
        allow(game_maker).to receive(:gets).and_return("1")
        game_maker.choose_starting_player
        expect(game_maker.game.current_player).to eq player1
      end

      it 'sets current player to 2 if chosen' do
        allow(game_maker).to receive(:gets).and_return("2")
        game_maker.choose_starting_player
        expect(game_maker.game.current_player).to eq player2
      end
    end

    context 'invalid input' do
      it 'outputs an error message if input does not relate to a player' do
        allow(game_maker).to receive(:gets).and_return("3", "1")
        message = "Invalid input! Please try again...\n\n"
        expect{ game_maker.choose_starting_player }.to output(message).to_stdout
      end

      it 'outputs an error message if input is empty' do
        allow(game_maker).to receive(:gets).and_return("", "1")
        message = "Invalid input! Please try again...\n\n"
        expect{ game_maker.choose_starting_player }.to output(message).to_stdout
      end
    end
  end
end
