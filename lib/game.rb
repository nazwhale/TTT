require_relative 'output_messages'
require_relative 'computer'
require_relative 'human'
require_relative 'board'

class Game

  attr_reader :board, :computer, :human

  def initialize
    @board = Board.new
    @computer = Computer.new("X")
    @human = Human.new
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

  def make_human_move
      choice = nil
      until choice
        choice = @human.get_move
        choice = nil if @board.occupied?(choice)
      end
      place_marker(@human, choice)
  end

  def make_computer_move
    unless @board.game_over?
      choice = @computer.get_square(@board)
      place_marker(@computer, choice)
    end
  end

  def place_marker(player, square)
    @board.state[square] = player.marker
  end

  def show_current_board
    Messages.print_board(board)
  end

  def show_game_over
    Messages.game_over_message
  end

end
