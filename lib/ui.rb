class UI

  def prompt_move(player)
    human?(player) ? prompt_human_move : computer_thinking
  end

  def move_confirmation(player, choice)
    human?(player) ? choice_confirmation(choice) : computer_move_confirmation(choice)
  end

  def welcome
    puts "Welcome to Tic-Tac-Toe!\n\n"
  end

  def ready_to_play(player1, player2, current_player)
    puts "\nPlayer 1 will play as: " + player1.symbol + "\n" +
         "Player 2 will play as: " + player2.symbol + "\n\n" +
         "The stage is set...\n" +
          current_player.symbol + " to go first!\n\n"
  end

  def choice_confirmation(choice)
    puts "You chose: " + choice.to_s + "\n\n"
  end

  def computer_move_confirmation(choice)
    puts "The Computer chose: " + choice.to_s + "\n\n"
  end

  def print_board(board)
    board.state.each_with_index do |square, index|
      print_occupant(index, square)
      print_board_part(board, index)
    end
  end

  def choose_player1_symbol
    puts "Choose a symbol for player 1!"
  end

  def choose_player2_symbol
    puts "What symbol will player 2 use?"
  end

  def wrong_symbol_length
    puts "Symbol must be 1 character long! Please try again."
  end

  def symbol_must_be_original
    puts "Choose a different symbol to player 1!"
  end

  def symbol_cant_be_integer
    puts "Symbol cannot be an integer! Please try again."
  end

  def choose_board_size
    puts "Select '3' to play or a 3x3 board or '4' to play on a 4x4 board."
  end

  def prompt_game_type
    puts "What kind of game would you like to play?\n" +
         "Select 1 for 😌  vs. 😌 \n" +
         "Select 2 for 😌  vs. 🤖 \n" +
         "Select 3 for 🤖  vs. 🤖 \n" 
    print "Your choice: "
  end

  def game_type_confirmation(player1_type, player2_type)
    puts "\nYou chose to play " + player1_type + " vs. " + player2_type
  end

  def choose_starting_player(player1, player2)
    puts "\nWho will play the first move?\n" +
         "Select 1 for: " + player1.symbol + "\n" +
         "Select 2 for: " + player2.symbol + "\n\n"
  end

  def try_again
    puts "Invalid input! Please try again...\n\n"
  end

  def prompt_human_move
    puts "Choose your move! Enter a number between 0 and 8..."
  end

  def computer_thinking
    print "The Computer is thinking...\n"
  end

  def tie_message
    puts "Even stevens!"
  end

  def win_message(winner)
    puts "Congratulations " + winner.symbol + ", you won!\n" +
         "🎉  🎉  🎉  🎉  🎉\n\n"
  end

  def see_you_again
    puts "See you next time 👋 "
  end

  def invalid_choice_message
    puts "Please choose one of the available squares!"
  end
  
  private

  def human?(player)
    player.class == Human
  end

  def print_occupant(index, square)
    if square == nil
      print index
      if index < 10
        print " "
      end
    else
      print square + " "
    end
  end

  def print_board_part(board, index)
    if (index + 1) == board.state.length
      print "\n\n"
    elsif (index + 1) % board.number_of_rows == 0
      print_line(board.number_of_rows)
    else
      print_divider
    end
  end

  def print_line(size)
    number_of_dividers = (size * 5) - 2
    print "\n" + ("=" * number_of_dividers) + "\n"
  end

  def print_divider
    print " | "
  end
end
