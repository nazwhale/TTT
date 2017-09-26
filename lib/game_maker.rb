require_relative 'game'

class GameMaker

  attr_reader :game
  attr_writer :game

  def initialize(ui)
    @game = nil
    @ui = ui
  end

  def new_game
    @ui.welcome

    player1_symbol = get_symbol(1, nil)
    player2_symbol = get_symbol(2, player1_symbol)

    choose_game_type(player1_symbol, player2_symbol)
    game_type_confirmation

    choose_starting_player
    ready_to_play_confirmation
    game_cycle

    game_over_confirmation
    @ui.see_you_again   
  end

  def game_cycle
    until @game.game_over?
      @ui.prompt_move(@game.current_player)
      move = @game.make_move(@game.current_player)
      game.place_symbol(@game.current_player, move)
      @ui.move_confirmation(@game.current_player, move)
      show_current_board
      @game.switch_player
    end
  end

  def get_symbol(player, opponent_symbol)
    player == 1 ? @ui.choose_player1_symbol : @ui.choose_player2_symbol
    loop do
    choice = gets.chomp
      if choice.length != 1
        @ui.wrong_symbol_length
      elsif choice == opponent_symbol
        @ui.symbol_must_be_original
      elsif is_an_integer?(choice)
        @ui.symbol_cant_be_integer
      else
        @ui.choice_confirmation(choice)
        return choice
      end
    end
  end

  def choose_game_type(player1_symbol, player2_symbol)
    loop do
    @ui.prompt_game_type
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
        @ui.try_again
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
    @ui.choose_starting_player(@game.player1, @game.player2)
    choice = gets.chomp
      case choice
      when "1"
        @game.current_player = @game.player1
        break
      when "2"
        @game.current_player = @game.player2
        break
      else
        @ui.try_again
      end
    end
  end

  private

  def is_an_integer?(choice)
    choice == "0" || choice.to_i != 0
  end

  def show_current_board
    @ui.print_board(@game.board)
  end
  
  def game_type_confirmation
    @ui.game_type_confirmation(@game.player1.class.to_s, @game.player2.class.to_s)
  end

  def game_over_confirmation
    @game.tie? ? @ui.tie_message : @ui.win_message(@game.get_opponent(@game.current_player))
  end

  def ready_to_play_confirmation
    @ui.ready_to_play(@game.player1, @game.player2, @game.current_player)
    show_current_board
  end
end
