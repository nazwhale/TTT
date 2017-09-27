require 'ui'

describe UI do

  subject(:ui) { described_class.new }
  let(:player1) { Human.new("X") }
  let(:player2) { Computer.new("O") }

  describe '#prompt_move' do
    it 'calls prompt_human_move for a Human' do
      allow(ui).to receive(:prompt_human_move)
      ui.prompt_move(player1)
      expect(ui).to have_received(:prompt_human_move).once
    end

    it 'calls computer_thinking for a Computer' do
      allow(ui).to receive(:computer_thinking)
      ui.prompt_move(player2)
      expect(ui).to have_received(:computer_thinking).once
    end
  end

  it 'welcomes the players to the game' do
    message = "Welcome to Tic-Tac-Toe!\n\n"
    expect{ ui.welcome }.to output(message).to_stdout
  end

  it 'ready to play message' do
    message = "\nPlayer 1 will play as: X\nPlayer 2 will play as: O\n\nThe stage is set...\nX to go first!\n\n"
    expect{ ui.ready_to_play(player1, player2, player1) }.to output(message).to_stdout
  end

  it 'choice confirmation' do
    message = "You chose: 3\n\n"
    expect{ ui.choice_confirmation(3) }.to output(message).to_stdout
  end

  it 'computer move confirmation' do
    message = "The Computer chose: 6\n\n"
    expect{ ui.computer_move_confirmation(6) }.to output(message).to_stdout
  end

  it 'prints the current board state' do
    board = double("board", :state => [nil, "X", nil, "O", "X", "O", nil, nil, nil] )
    printed_board = "0 | X | 2\n==========\nO | X | O\n==========\n6 | 7 | 8\n\n"
    expect{ ui.print_board(board) }.to output(printed_board).to_stdout
  end

  it 'prompts choice of player1 symbol' do
    message = "Choose a symbol for player 1!\n"
    expect{ ui.choose_player1_symbol }.to output(message).to_stdout
  end

  it 'prompts choice of player2 symbol' do
    message = "What symbol will player 2 use?\n"
    expect{ ui.choose_player2_symbol }.to output(message).to_stdout
  end

  it 'wrong symbol length message' do
    message = "Symbol must be 1 character long! Please try again.\n"
    expect{ ui.wrong_symbol_length }.to output(message).to_stdout
  end

  it 'symbol must be original message' do
    message = "Choose a different symbol to player 1!\n"
    expect{ ui.symbol_must_be_original }.to output(message).to_stdout
  end

  it 'symbol_cant_be_integer' do
    message = "Symbol cannot be an integer! Please try again.\n"
    expect{ ui.symbol_cant_be_integer }.to output(message).to_stdout
  end

  it 'prompts choice of game type' do
    message = "What kind of game would you like to play?\nSelect 1 for 😌  vs. 😌 \nSelect 2 for 😌  vs. 🤖 \nSelect 3 for 🤖  vs. 🤖 \nYour choice: "
    expect{ ui.prompt_game_type }.to output(message).to_stdout
  end

  it 'outputs the type of game' do
    confirmation = "\nYou chose to play Human vs. Computer\n"
    expect{ ui.game_type_confirmation("Human", "Computer") }.to output(confirmation).to_stdout
  end

  it 'prompts user to choose the player that will start the game' do
    confirmation = "\nWho will play the first move?\nSelect 1 for: X\nSelect 2 for: O\n\n"
    expect{ ui.choose_starting_player(player1, player2) }.to output(confirmation).to_stdout
  end

  it 'prompts the user to try and make a move again' do
    message = "Invalid input! Please try again...\n\n"
    expect{ ui.try_again }.to output(message).to_stdout
  end

  it 'prompts the user to make a move' do
    message = "Choose your move! Enter a number between 0 and 8...\n"
    expect{ ui.prompt_human_move }.to output(message).to_stdout
  end

  it 'displays computer thinking message' do
    message = "The Computer is thinking...\n"
    expect{ ui.computer_thinking }.to output(message).to_stdout
  end

  it 'displays tie message' do
    message = "Even stevens!\n"
    expect{ ui.tie_message }.to output(message).to_stdout
  end

  it 'displays win message with winners symbol' do
    message = "Congratulations X, you won!\n🎉  🎉  🎉  🎉  🎉\n\n"
    expect{ ui.win_message(player1) }.to output(message).to_stdout
  end

  it 'displays see you again message' do
    message = "See you next time 👋 \n"
    expect{ ui.see_you_again }.to output(message).to_stdout
  end

  it 'displays invalid choice message' do
    message = "Please choose one of the available squares!\n"
    expect{ ui.invalid_choice_message }.to output(message).to_stdout
  end
end
