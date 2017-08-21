require_relative 'output_messages'
require_relative 'computer'
require_relative 'human'
require_relative 'board'

class Game

  attr_reader :board, :computer, :human

  def initialize
    @board = Board.new
    @computer = Computer.new
    @human = Human.new
  end

  def play
    show_current_board
    # loop through until the game is won or tied
    until @board.game_over?
      make_human_move
      make_computer_move
      show_current_board
    end
    Messages.game_over_message
  end

  private

  def make_human_move
      humans_choice = nil
      until humans_choice
        humans_choice = gets.chomp.to_i
        current_value = @board.state[humans_choice]
        humans_choice = nil if @board.occupied?(current_value)
      end
      @board.state[humans_choice] = @human.marker
  end

  def make_computer_move
    unless @board.game_over?
      computers_choice = @computer.get_square(@board)
      @board.state[computers_choice] = @computer.marker
    end
  end

  def show_current_board
    Messages.print_board(board)
  end

end
