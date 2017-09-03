require 'messages'

describe Messages do

  let(:player1) { Human.new("X") }
  let(:player2) { Computer.new("O") }

  describe '#ready_to_play' do
    it 'outputs both players symbols' do
      message = "\nPlayer 1 will play as: X\nPlayer 2 will play as: O\n\nThe stage is set...\n"
      expect{ Messages.ready_to_play(player1, player2) }.to output(message).to_stdout
    end
  end

  describe '#print_board' do
    it 'outputs the current board state' do
      board = double("board", :state => ["0", "X", "2", "O", "X", "O", "6", "7", "8"] )
      printed_board = "\n0 | X | 2\n==========\nO | X | O\n==========\n6 | 7 | 8\n\n"
      expect{ Messages.print_board(board) }.to output(printed_board).to_stdout
    end
  end

  describe '#choose_player1_symbol' do
    it 'displays appropriate message' do
      message = "Choose a symbol for player 1!\n"
      expect{ Messages.choose_player1_symbol }.to output(message).to_stdout
    end
  end

  describe '#choose_player2_symbol' do
    it 'displays appropriate message' do
      message = "What symbol will player 2 use?\n"
      expect{ Messages.choose_player2_symbol }.to output(message).to_stdout
    end
  end

  describe '#promt_game_type' do
    it 'displays appropriate message' do
      message = "What kind of game would you like to play?\nSelect 1 for 😌  vs. 😌 \nSelect 2 for 😌  vs. 🤖 \nSelect 3 for 🤖  vs. 🤖 \nYour choice: "
      expect{ Messages.prompt_game_type }.to output(message).to_stdout
    end
  end

  describe '#game_type_confirmation' do
    it 'outputs the type of game' do
      confirmation = "\nYou chose to play Human vs. Computer\n\n"
      expect{ Messages.game_type_confirmation("Human", "Computer") }.to output(confirmation).to_stdout
    end
  end

  describe '#try_again' do
    it 'displays appropriate message' do
      message = "Invalid input! Please try again...\n\n"
      expect{ Messages.try_again }.to output(message).to_stdout
    end
  end

  describe '#prompt_move' do
    it 'displays appropriate message' do
      message = "Choose your move! Enter a number between 0 and 8...\n"
      expect{ Messages.prompt_move }.to output(message).to_stdout
    end
  end
end
