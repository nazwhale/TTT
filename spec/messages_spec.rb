require 'messages'

describe Messages do

  let(:player1) { Human.new("X") }
  let(:player2) { Computer.new("O") }

  it 'welcomes the players to the game' do
    message = "Welcome to Tic-Tac-Toe!\n\n"
    expect{ Messages.welcome }.to output(message).to_stdout
  end

  it 'ready to play message' do
    message = "\nPlayer 1 will play as: X\nPlayer 2 will play as: O\n\nThe stage is set...\nX to go first!\n\n"
    expect{ Messages.ready_to_play(player1, player2, player1) }.to output(message).to_stdout
  end

  it 'human move confirmation' do
    message = "You chose: 3\n\n"
    expect{ Messages.human_move_confirmation(3) }.to output(message).to_stdout
  end

  it 'computer move confirmation' do
    message = "The Computer chose: 6\n\n"
    expect{ Messages.computer_move_confirmation(6) }.to output(message).to_stdout
  end

  it 'prints the current board state' do
    board = double("board", :state => ["0", "X", "2", "O", "X", "O", "6", "7", "8"] )
    printed_board = "0 | X | 2\n==========\nO | X | O\n==========\n6 | 7 | 8\n\n"
    expect{ Messages.print_board(board) }.to output(printed_board).to_stdout
  end

  it 'prompts choice of player1 symbol' do
    message = "Choose a symbol for player 1!\n"
    expect{ Messages.choose_player1_symbol }.to output(message).to_stdout
  end

  it 'prompts choice of player2 symbol' do
    message = "What symbol will player 2 use?\n"
    expect{ Messages.choose_player2_symbol }.to output(message).to_stdout
  end

  it 'prompts choice of game type' do
    message = "What kind of game would you like to play?\nSelect 1 for 😌  vs. 😌 \nSelect 2 for 😌  vs. 🤖 \nSelect 3 for 🤖  vs. 🤖 \nYour choice: "
    expect{ Messages.prompt_game_type }.to output(message).to_stdout
  end

  it 'outputs the type of game' do
    confirmation = "\nYou chose to play Human vs. Computer\n"
    expect{ Messages.game_type_confirmation("Human", "Computer") }.to output(confirmation).to_stdout
  end

  it 'prompts user to choose the player that will start the game' do
    confirmation = "\nWho will play the first move?\nSelect 1 for: X\nSelect 2 for: O\n\n"
    expect{ Messages.choose_starting_player(player1, player2) }.to output(confirmation).to_stdout
  end

  it 'prompts the user to try and make a move again' do
    message = "Invalid input! Please try again...\n\n"
    expect{ Messages.try_again }.to output(message).to_stdout
  end

  it 'prompts the user to make a move' do
    message = "Choose your move! Enter a number between 0 and 8...\n"
    expect{ Messages.prompt_move }.to output(message).to_stdout
  end

  it 'displays computer thinking message' do
    allow(Messages).to receive(:sleep)
    message = "The Computer is thinking... ... ...\n"
    expect{ Messages.computer_thinking }.to output(message).to_stdout
  end

  it 'displays tie message' do
    message = "Even stevens!\n"
    expect{ Messages.tie_message }.to output(message).to_stdout
  end

  it 'displays win message with winners symbol' do
    message = "Congratulations X, you won!\n🎉  🎉  🎉  🎉  🎉\n\n"
    expect{ Messages.win_message(player1) }.to output(message).to_stdout
  end

  it 'displays see you again message' do
    message = "See you next time 👋 \n"
    expect{ Messages.see_you_again }.to output(message).to_stdout
  end

  it 'displays invalid choice message' do
    message = "Please choose one of the available squares!\n"
    expect{ Messages.invalid_choice_message }.to output(message).to_stdout
  end
end
