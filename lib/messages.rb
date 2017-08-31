require_relative 'game'

class Messages

  attr_reader :game

  def self.print_board(board)
    puts "#{board.state[0]} | #{board.state[1]} | #{board.state[2]}"
    print_line
    puts "#{board.state[3]} | #{board.state[4]} | #{board.state[5]}"
    print_line
    puts "#{board.state[6]} | #{board.state[7]} | #{board.state[8]}"
    prompt_move
  end

  def self.print_line
    puts "=========="
  end

  def self.choose_symbol_prompt
    puts "Choose your symbol!"
  end

  def self.game_type_confirmation(player1, player2)
    puts "You chose to play " + player1 + " vs. " + player2
  end

  def self.try_again
    puts "Invalid input! Please choose 1, 2, or 3"
  end

  def self.prompt_move
    puts "Choose your move! Enter a number between 0 and 8"
  end

  def self.game_over_message
    puts "Game over!"
  end

end
