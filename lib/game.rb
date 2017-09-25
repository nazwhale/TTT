require_relative 'messages'
require_relative 'computer'
require_relative 'human'
require_relative 'board'

class Game

  attr_reader :player1, :player2, :board, :current_player
  attr_writer :current_player

  def initialize(player1, player2, board = Board.new)
    @player1 = player1
    @player2 = player2
    @board = board
    @current_player = nil
  end

  def play
    show_current_board   # MESSAGES
    until game_over?
      make_move(@current_player)
      show_current_board   # MESSAGES
      switch_player
    end
  end

  def make_move(player)
    human_player?(player) ? make_human_move(player) : make_computer_move(player)
  end

  def make_human_move(player)
    prompt_move   # MESSAGES
    choice = get_human_input
    place_symbol(player, choice)
    human_move_confirmation(choice)  # MESSAGES
  end

  def make_computer_move(player)
    computer_thinking   # MESSAGES
    choice = player.get_move(self)
    place_symbol(player, choice)
    computer_move_confirmation(choice)   # MESSAGES
  end

  def get_opponent(player)
    @player1 == player ? @player2 : @player1
  end

  def switch_player
    @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
  end

  def place_symbol(player, choice)
    @board.state[choice] = player.symbol
  end

  def game_over_message
    switch_player
    tie? ? tie_message : win_message(@current_player)   # MESSAGES
    see_you_again   # MESSAGES
  end

  private

  def get_human_input
    choice = nil
    until choice
      choice = gets.chomp
      if choice_invalid?(choice)
        invalid_choice_message   # MESSAGES
        choice = nil
      end
    end
    choice.to_i
  end

  def choice_invalid?(choice)
    @board.occupied?(choice) || choice == ""
  end

  def game_over?
    @board.game_over?(@player1, @player2)
  end

  def tie?
    @board.tie?(@player1, @player2)
  end

  def human_player?(player)
    player.class == Human
  end

  def prompt_move
    Messages.prompt_move
  end

  def human_move_confirmation(move)
    Messages.choice_confirmation(move)
  end

  def computer_move_confirmation(move)
    Messages.computer_move_confirmation(move)
  end

  def computer_thinking
    Messages.computer_thinking
  end

  def show_current_board
    Messages.print_board(board)
  end

  def tie_message
    Messages.tie_message
  end

  def win_message(winner)
    Messages.win_message(winner)
  end

  def see_you_again
    Messages.see_you_again
  end

  def invalid_choice_message
    Messages.invalid_choice_message
  end
end
