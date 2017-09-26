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

  def make_move(player)
    human_player?(player) ? make_human_move(player) : make_computer_move(player)
  end

  def make_human_move(player)
    get_human_input
  end

  def make_computer_move(player)
    player.get_move(self)
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

  def game_over?
    @board.game_over?(@player1, @player2)
  end

  def tie?
    @board.tie?(@player1, @player2)
  end

  private

  def get_human_input
    choice = nil
    until choice
      choice = gets.chomp
      if choice_invalid?(choice)
        choice = nil
      end
    end
    choice.to_i
  end

  def choice_invalid?(choice)
    @board.occupied?(choice) || choice == ""
  end


  def human_player?(player)
    player.class == Human
  end

end
