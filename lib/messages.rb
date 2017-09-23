class Messages

  def self.welcome
    puts "Welcome to Tic-Tac-Toe!\n\n"
  end

  def self.ready_to_play(player1, player2, current_player)
    puts "\nPlayer 1 will play as: " + player1.symbol + "\n" +
         "Player 2 will play as: " + player2.symbol + "\n\n" +
         "The stage is set...\n" +
          current_player.symbol + " to go first!\n\n"
  end

  def self.choice_confirmation(choice)
    puts "You chose: " + choice.to_s + "\n\n"
  end

  def self.computer_move_confirmation(choice)
    puts "The Computer chose: " + choice.to_s + "\n\n"
  end

  def self.print_board(board)
    puts "#{board.state[0]} | #{board.state[1]} | #{board.state[2]}"
    print_line
    puts "#{board.state[3]} | #{board.state[4]} | #{board.state[5]}"
    print_line
    puts "#{board.state[6]} | #{board.state[7]} | #{board.state[8]}\n\n"
  end

  def self.print_line
    puts "=========="
  end

  def self.choose_player1_symbol
    puts "Choose a symbol for player 1!"
  end

  def self.choose_player2_symbol
    puts "What symbol will player 2 use?"
  end

  def self.wrong_symbol_length
    puts "Symbol must be 1 character long! Please try again."
  end

  def self.symbol_must_be_original
    puts "Choose a different symbol to player 1!"
  end

  def self.symbol_cant_be_integer
    puts "Symbol cannot be an integer! Please try again."
  end

  def self.prompt_game_type
    puts "What kind of game would you like to play?\n" +
         "Select 1 for 😌  vs. 😌 \n" +
         "Select 2 for 😌  vs. 🤖 \n" +
         "Select 3 for 🤖  vs. 🤖 \n" 
    print "Your choice: "
  end

  def self.game_type_confirmation(player1_type, player2_type)
    puts "\nYou chose to play " + player1_type + " vs. " + player2_type
  end

  def self.choose_starting_player(player1, player2)
    puts "\nWho will play the first move?\n" +
         "Select 1 for: " + player1.symbol + "\n" +
         "Select 2 for: " + player2.symbol + "\n\n"
  end

  def self.try_again
    puts "Invalid input! Please try again...\n\n"
  end

  def self.prompt_move
    puts "Choose your move! Enter a number between 0 and 8..."
  end

  def self.computer_thinking
    print "The Computer is thinking...\n"
  end

  def self.tie_message
    puts "Even stevens!"
  end

  def self.win_message(winner)
    puts "Congratulations " + winner.symbol + ", you won!\n" +
         "🎉  🎉  🎉  🎉  🎉\n\n"
  end

  def self.see_you_again
    puts "See you next time 👋 "
  end

  def self.invalid_choice_message
    puts "Please choose one of the available squares!"
  end

end
