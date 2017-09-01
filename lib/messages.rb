require_relative 'game'

class Messages

  attr_reader :game

  def self.ready_to_play(player1, player2)
    puts
    puts "Player 1 will play as: " + player1.symbol
    puts "Player 2 will play as: " + player2.symbol
    puts
    puts "The stage is set..."
  end

  def self.print_board(board)
    puts
    puts "#{board.state[0]} | #{board.state[1]} | #{board.state[2]}"
    print_line
    puts "#{board.state[3]} | #{board.state[4]} | #{board.state[5]}"
    print_line
    puts "#{board.state[6]} | #{board.state[7]} | #{board.state[8]}"
    puts
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

  def self.prompt_game_type
    puts "What kind of game would you like to play?"
    puts "Select 1 for 😌  vs. 😌 "
    puts "Select 2 for 😌  vs. 🤖 "
    puts "Select 3 for 🤖  vs. 🤖 "
  end

  def self.game_type_confirmation(player1, player2)
    puts "You chose to play " + player1.class.to_s + " vs. " + player2.class.to_s
  end

  def self.try_again
    puts "Invalid input! Please try again..."
  end

  def self.prompt_move
    puts "Choose your move! Enter a number between 0 and 8..."
  end

  def self.computer_thinking
    print "The Computer is thinking"
    sleep(1)
    print "... "
    sleep(1)
    print "... "
    sleep(1)
    puts "..."
    sleep(1)
  end

  def self.tie_message
    puts "Even stevens!"
  end

  def self.win_message(winner)
    puts "Congratulations " + winner.symbol + ", you won!"
    puts "🎉  🎉  🎉  🎉  🎉"
    puts
  end

  def self.see_you_again
    puts "See you next time 👋 "
  end

end
