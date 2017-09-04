require_relative 'game'

class GameMaker

  attr_reader :game

  def initialize
    @game = nil
  end

  def new_game
    choose_game_type
    show_game_type_confirmation(@game.player1.class.to_s, @game.player2.class.to_s)
    @game.who_goes_first
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
        try_again_message
      end
    end
  end

  private

  def human_vs_human

    choose_player1_symbol_message
    player1_symbol = get_symbol

    choose_player2_symbol_message
    player2_symbol = get_symbol

    @game = Game.new(Human.new(player1_symbol), Human.new(player2_symbol))
  end

  def human_vs_computer
    @game = Game.new(Human.new(get_player1_symbol), Computer.new(get_player2_symbol))
  end

  def computer_vs_computer
    @game = Game.new(Computer.new(get_player1_symbol), Computer.new(get_player2_symbol))
  end

  def get_symbol
    loop do
    choice = gets.chomp
      case choice
      when choice.length != 1
        #wrong length message
      when taken?(choice)
        #choice taken message
      else
        #confirmation message
        break
      end
    end
  end

  def ready_to_play_message
    Messages.ready_to_play(@game.player1, @game.player2, @game.current_player)
  end

  def prompt_game_type
    Messages.prompt_game_type
  end

  def choose_player1_symbol_message
    Messages.choose_player1_symbol
  end

  def choose_player2_symbol_message
    Messages.choose_player2_symbol
  end

  def show_game_type_confirmation(player1_type, player2_type)
    Messages.game_type_confirmation(player1_type, player2_type)
  end

  def try_again_message
    Messages.try_again
  end
end
