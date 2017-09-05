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

  def human_vs_human
    choose_player1_symbol_message
    player1_symbol = get_symbol(nil)

    choose_player2_symbol_message
    player2_symbol = get_symbol(player1_symbol)

    @game = Game.new(Human.new(player1_symbol), Human.new(player2_symbol))
  end

  def human_vs_computer
    choose_player1_symbol_message
    player1_symbol = get_symbol(nil)

    choose_player2_symbol_message
    player2_symbol = get_symbol(player1_symbol)
    @game = Game.new(Human.new(player1_symbol), Computer.new(player2_symbol))
  end

  def computer_vs_computer
    choose_player1_symbol_message
    player1_symbol = get_symbol(nil)

    choose_player2_symbol_message
    player2_symbol = get_symbol(player1_symbol)
    @game = Game.new(Computer.new(player1_symbol), Computer.new(player2_symbol))
  end

  def get_symbol(opponent_symbol)
    loop do
    choice = gets.chomp
      if choice.length != 1
        puts "Symbol must be 1 long! Please try again."
      elsif choice == opponent_symbol
        puts "Choose a different symbol to player 1!"
      else
        puts "You chose: " + choice
        return choice
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
