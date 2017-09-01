require_relative 'game'

class GameMaker

  attr_reader :game

  def initialize
    @game = nil
  end

  def new_game
    choose_game_type
    ready_to_play_message
    @game.play
  end

  def choose_game_type
    loop do
    prompt_game_type
    game_type = gets.chomp.to_i
      case game_type
      when 1
        human_vs_human
        break
      when 2
        human_vs_computer
        break
      when 3
        computer_vs_computer
        break
      else
        Messages.try_again
      end
    end
  end

  private

  def ready_to_play_message
    Messages.ready_to_play(@game.player1, @game.player2)
  end

  def prompt_game_type
    Messages.prompt_game_type
  end

  def human_vs_human
    @game = Game.new(Human.new(get_player1_symbol), Human.new(get_player2_symbol))
  end

  def human_vs_computer
    @game = Game.new(Human.new(get_player1_symbol), Computer.new(get_player2_symbol))
  end

  def computer_vs_computer
    @game = Game.new(Computer.new(get_player1_symbol), Computer.new(get_player2_symbol))
  end

  def get_player1_symbol
    Messages.choose_player1_symbol
    gets.chomp
  end

  def get_player2_symbol
    Messages.choose_player2_symbol
    gets.chomp
  end

  def show_game_type_confirmation
    Messages.game_type_confirmation(@game.player1, @game.player2)
  end

end
