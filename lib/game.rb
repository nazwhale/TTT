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

end
