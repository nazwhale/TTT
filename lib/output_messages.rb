require_relative 'game'

class Messages

  attr_reader :game

  def self.line
    puts "=========="
  end

  def self.move_prompt
    puts "Choose your move! Enter a number between 0 and 8"
  end

  def self.game_over_message
    puts "Game over!"
  end

end
