require_relative 'game'

class Messages

  attr_reader :game

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
    puts "Select 1 for Human vs. Human"
    puts "Select 2 for Human vs. Computer"
    puts "Select 3 for Computer vs. Computer"
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

  def self.game_over_message
    puts "Game over!"
  end

  def self.computer_thinking
    puts "The Computer is thinking..."
    sleep(0.5)
    puts "..."
    sleep(1)
  end

end
