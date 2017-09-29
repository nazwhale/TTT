require_relative 'game'

class GameMaker

  attr_reader :game
  attr_writer :game

  def initialize(ui, validator)
    @game = nil
    @ui = ui
    @validator = validator
  end

  def new_game
    @ui.welcome

    player1_symbol = get_symbol(1, nil)
    player2_symbol = get_symbol(2, player1_symbol)

    choose_game_type(player1_symbol, player2_symbol, choose_board_size)
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

      move = get_human_move(@game.board) if human_turn?
      move = @game.make_move(@game.current_player) if computer_turn?
      game.place_symbol(@game.current_player, move)

      move_confirmation(move)
      @game.switch_player
    end
  end

  def get_human_move(board)
    loop do
      move = gets.chomp
      if @validator.move_invalid?(board, move)
        @ui.invalid_choice_message
      else
        return move.to_i
      end
    end
  end

  def get_symbol(player, opponent_symbol)
    player == 1 ? @ui.choose_player1_symbol : @ui.choose_player2_symbol
    loop do
      choice = gets.chomp
      if @validator.symbol_invalid?(choice, opponent_symbol)
        @ui.invalid_symbol_message
      else
        @ui.choice_confirmation(choice)
        return choice
      end
    end
  end

  def choose_board_size
    loop do
    @ui.choose_board_size
    choice = gets.chomp
      case choice
      when "3"
        return 3
      when "4"
        return 4
      else
        @ui.try_again
      end
    end
  end

  def choose_game_type(player1_symbol, player2_symbol, board_size)
    loop do
    @ui.prompt_game_type
    game_type = gets.chomp
      case game_type
      when "1"
        human_vs_human(player1_symbol, player2_symbol, board_size)
        break
      when "2"
        human_vs_computer(player1_symbol, player2_symbol, board_size)
        break
      when "3"
        computer_vs_computer(player1_symbol, player2_symbol, board_size)
        break
      else
        @ui.try_again
      end
    end
  end

  def human_vs_human(player1_symbol, player2_symbol, board_size)
    @game = Game.new(Human.new(player1_symbol), Human.new(player2_symbol), Board.new(board_size))
  end

  def human_vs_computer(player1_symbol, player2_symbol, board_size)
    @game = Game.new(Human.new(player1_symbol), Computer.new(player2_symbol), Board.new(board_size))
  end

  def computer_vs_computer(player1_symbol, player2_symbol, board_size)
    @game = Game.new(Computer.new(player1_symbol), Computer.new(player2_symbol), Board.new(board_size))
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

  def human_turn?
    @game.current_player.is_a? Human
  end

  def computer_turn?
    @game.current_player.is_a? Computer
  end

  def move_confirmation(move)
    @ui.move_confirmation(@game.current_player, move)
    show_current_board
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
