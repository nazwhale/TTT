require_relative 'messages'
require_relative 'computer'
require_relative 'human'
require_relative 'board'

class Game

  attr_reader :board, :computer, :human

  def initialize
    @board = Board.new
    @human = create_human
    @computer = create_computer
  end

  def play
    until @board.game_over?
      show_current_board
      make_human_move
      make_computer_move
    end
    show_current_board
    show_game_over
  end

  private

  def create_human
    symbol = gets.chomp
    Human.new(symbol)
  end

  def create_computer
    symbol = gets.chomp
    Computer.new(symbol, @human.symbol)
  end

  def make_human_move
      choice = nil
      until choice
        choice = @human.get_move
        choice = nil if @board.occupied?(choice)
      end
      place_symbol(@human, choice)
  end

  def make_computer_move
    unless @board.game_over?
      choice = @computer.get_square(@board)
      place_symbol(@computer, choice)
    end
  end

  def place_symbol(player, square)
    @board.state[square] = player.symbol
  end

  def show_current_board
    Messages.print_board(board)
  end

  def show_game_over
    Messages.game_over_message
  end

end
