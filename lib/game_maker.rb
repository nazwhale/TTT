require_relative 'game'

class GameMaker

  attr_reader :game
  attr_writer :game

  def initialize
    @game = nil
  end

  def new_game
    welcome_message

    player1_symbol = get_symbol(1, nil)
    player2_symbol = get_symbol(2, player1_symbol)

    choose_game_type(player1_symbol, player2_symbol)
    show_game_type_confirmation(@game.player1.class.to_s, @game.player2.class.to_s)

    choose_starting_player
    ready_to_play_message
    @game.play

    @game.game_over_message
  end

  def get_symbol(player, opponent_symbol)
    player == 1 ? choose_player1_symbol_message : choose_player2_symbol_message
    loop do
    choice = gets.chomp
      if choice.length != 1
        wrong_symbol_length_message
      elsif choice == opponent_symbol
        symbol_must_be_original_message
      elsif is_an_integer?(choice)
        symbol_cant_be_integer_message
      else
        choice_confirmation(choice)
        return choice
      end
    end
  end

  def choose_game_type(player1_symbol, player2_symbol)
    loop do
    prompt_game_type
    game_type = gets.chomp.to_i
      case game_type
      when 1
        human_vs_human(player1_symbol, player2_symbol)
        break
      when 2
        human_vs_computer(player1_symbol, player2_symbol)
        break
      when 3
        computer_vs_computer(player1_symbol, player2_symbol)
        break
      else
        try_again_message
      end
    end
  end

  def human_vs_human(player1_symbol, player2_symbol)
    @game = Game.new(Human.new(player1_symbol), Human.new(player2_symbol))
  end

  def human_vs_computer(player1_symbol, player2_symbol)
    @game = Game.new(Human.new(player1_symbol), Computer.new(player2_symbol))
  end

  def computer_vs_computer(player1_symbol, player2_symbol)
    @game = Game.new(Computer.new(player1_symbol), Computer.new(player2_symbol))
  end

  def choose_starting_player
    loop do
    choose_starting_player_message
    choice = gets.chomp
      case choice
      when "1"
        @game.current_player = @game.player1
        break
      when "2"
        @game.current_player = @game.player2
        break
      else
        try_again_message
      end
    end
  end

  private

  def is_an_integer?(choice)
    choice == "0" || choice.to_i != 0
  end

  def choose_player1_symbol_message
    Messages.choose_player1_symbol
  end

  def choose_player2_symbol_message
    Messages.choose_player2_symbol
  end

  def wrong_symbol_length_message
    Messages.wrong_symbol_length
  end

  def symbol_must_be_original_message
    Messages.symbol_must_be_original
  end

  def symbol_cant_be_integer_message
    Messages.symbol_cant_be_integer
  end

  def choose_starting_player_message
    Messages.choose_starting_player(@game.player1, @game.player2)
  end

  def welcome_message
    Messages.welcome
  end

  def try_again_message
    Messages.try_again
  end

  def ready_to_play_message
    Messages.ready_to_play(@game.player1, @game.player2, @game.current_player)
  end

  def prompt_game_type
    Messages.prompt_game_type
  end

  def show_game_type_confirmation(player1_type, player2_type)
    Messages.game_type_confirmation(player1_type, player2_type)
  end

  def choice_confirmation(choice)
    Messages.choice_confirmation(choice)
  end

end
