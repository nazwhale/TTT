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

  describe '#game_type_confirmation' do
    it 'outputs the type of game' do
      confirmation = "You chose to play Human vs. Computer\n"
      expect{ Messages.game_type_confirmation(player1, player2) }.to output(confirmation).to_stdout
    end
  end
end
