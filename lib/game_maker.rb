require_relative 'game'

class GameMaker

  attr_reader :game
  attr_writer :game

  def initialize
    @game = nil
  end

  def new_game
    welcome_message

    choose_player1_symbol_message
    player1_symbol = get_symbol(nil)

    choose_player2_symbol_message
    player2_symbol = get_symbol(player1_symbol)

    choose_game_type(player1_symbol, player2_symbol)
    show_game_type_confirmation(@game.player1.class.to_s, @game.player2.class.to_s)

    choose_starting_player
    ready_to_play_message
    @game.play
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

  def get_symbol(opponent_symbol)
    loop do
    choice = gets.chomp
      if choice.length != 1
        puts "Symbol must be 1 character long! Please try again."
      elsif choice == opponent_symbol
        puts "Choose a different symbol to player 1!"
      elsif is_an_integer?(choice)
        puts "Symbol cannot be an integer! Please try again."
      else
        puts "You chose: " + choice
        puts
        return choice
      end
    end
  end

  def is_an_integer?(choice)
    /\A[-+]?\d+\z/.match(choice)
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
        puts "Invalid input!"
      end
    end
  end

  def choose_starting_player_message
    Messages.choose_starting_player(@game.player1, @game.player2)
  end

  def choose_player1_symbol_message
    Messages.choose_player1_symbol
  end

  def choose_player2_symbol_message
    Messages.choose_player2_symbol
  end

  private

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

end
