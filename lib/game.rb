require_relative 'output_messages'
require_relative 'computer'
require_relative 'human'

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
    until game_is_over(@board) || tie(@board)

      humans_choice = nil
      #if choice taken, ask again
      until humans_choice
        humans_choice = gets.chomp.to_i
        humans_choice = nil if board[humans_choice] == "X" || board[humans_choice] == "O"
      end

      @board[humans_choice] = @human.marker

      unless game_is_over(@board) || tie(@board)
        computers_choice = @computer.get_square(@board)
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
    board.all? { |square| square == @computer.marker || square == @human.marker }
  end

end
