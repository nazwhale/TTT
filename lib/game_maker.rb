require_relative 'game'

class GameMaker

  attr_reader :game

  def initialize
    @game = nil
  end

  def play
    choose_game_type
    @game.play
  end

  def choose_game_type
    game_type = gets.chomp.to_i
    case game_type
    when 1
      human_vs_human
    when 2
      human_vs_computer
    when 3
      computer_vs_computer
    else
      Messages.try_again
    end
  end

  private

  def human_vs_human
    @game = Game.new(Human.new(get_symbol), Human.new(get_symbol))
  end

  def human_vs_computer
    @game = Game.new(Human.new(get_symbol), Computer.new(get_symbol))
  end

  def computer_vs_computer
    @game = Game.new(Computer.new(get_symbol), Computer.new(get_symbol))
  end

  def get_symbol
    Messages.choose_symbol_prompt
    gets.chomp
  end

  def show_game_type_confirmation
    Messages.game_type_confirmation(@game.player1.class.to_s, @game.player2.class.to_s)
  end

end
