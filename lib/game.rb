require_relative 'messages'
require_relative 'computer'
require_relative 'human'
require_relative 'board'

class Game

  attr_reader :board, :computer, :human

  def initialize(player1, player2)
    @board = Board.new
    @player1 = player1
    @player2 = player2
  end

  def play
    until @board.game_over?
      show_current_board
      @player1.class == Human ? make_human_move(@player1) : make_computer_move(@player1)
      @player2.class == Human ? make_human_move(@player2) : make_computer_move(@player2)
    end
    show_current_board
    show_game_over
  end

  private

  def get_symbol
    choose_symbol_prompt
    gets.chomp
  end

  def make_human_move(player)
      choice = nil
      until choice
        choice = player.get_move
        choice = nil if @board.occupied?(choice)
      end
      place_symbol(player, choice)
  end

  def make_computer_move(player)
    unless @board.game_over?
      choice = player.get_square(@board)
      place_symbol(player, choice)
    end
  end

  def place_symbol(player, square)
    @board.state[square] = player.symbol
  end

  def choose_symbol_prompt(player)
    Messages.choose_symbol_prompt(player)
  end

  def show_current_board
    Messages.print_board(board)
  end

  def show_game_over
    Messages.game_over_message
  end

end
