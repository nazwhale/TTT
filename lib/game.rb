require_relative 'output_messages'
require_relative 'computer'

class Game

  attr_reader :board, :computer, :human
  attr_writer :board

  HUMAN_MARKER = "O"
  EMPTY_BOARD = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
  MIDDLE_SQUARE_INDEX = "4"

  def initialize
    @board = EMPTY_BOARD
    @computer = Computer.new
    @human = HUMAN_MARKER
  end

  def start_game
    show_current_board
    # loop through until the game was won or tied
    until game_is_over(@board) || tie(@board)
      get_human_square
      if !game_is_over(@board) && !tie(@board)
        computers_choice = @computer.choose_square(@board)
        @board[computers_choice] = @computer.marker
      end
      show_current_board
    end
    Messages.game_over_message
  end

  def show_current_board
    puts "#{@board[0]} | #{@board[1]} | #{@board[2]}"
    Messages.line
    puts "#{@board[3]} | #{@board[4]} | #{@board[5]}"
    Messages.line
    puts "#{@board[6]} | #{@board[7]} | #{@board[8]}"
    Messages.move_prompt
  end

  def get_human_square
    square = nil
    until square
      square = gets.chomp.to_i
      if @board[square] != @computer.marker && @board[square] != HUMAN_MARKER
        @board[square] = @human
      else
        square = nil
      end
    end
  end

  def game_is_over(board)
    [board[0], board[1], board[2]].uniq.length == 1 ||
    [board[3], board[4], board[5]].uniq.length == 1 ||
    [board[6], board[7], board[8]].uniq.length == 1 ||
    [board[0], board[3], board[6]].uniq.length == 1 ||
    [board[1], board[4], board[7]].uniq.length == 1 ||
    [board[2], board[5], board[8]].uniq.length == 1 ||
    [board[0], board[4], board[8]].uniq.length == 1 ||
    [board[2], board[4], board[6]].uniq.length == 1
  end

  def tie(board)
    board.all? { |square| square == @computer.marker || square == HUMAN_MARKER }
  end

end
