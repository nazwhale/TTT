require_relative 'output_messages'
class Game

  attr_reader :board, :computer, :human

  COMPUTER_MARKER = "X"
  HUMAN_MARKER = "O"
  EMPTY_BOARD = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]

  def initialize
    @board = EMPTY_BOARD
    @computer = COMPUTER_MARKER
    @human = HUMAN_MARKER
  end

  def start_game
    show_current_board

    # loop through until the game was won or tied
    until game_is_over(@board) || tie(@board)
      get_human_square
      if !game_is_over(@board) && !tie(@board)
        eval_board
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
      if @board[square] != COMPUTER_MARKER && @board[square] != HUMAN_MARKER
        @board[square] = @human
      else
        square = nil
      end
    end
  end

  def eval_board
    square = nil
    until square
      if @board[4] == "4"
        square = 4
        @board[square] = @computer
      else
        square = get_best_move(@board, @computer)
        if @board[square] != COMPUTER_MARKER && @board[square] != HUMAN_MARKER
          @board[square] = @computer
        else
          square = nil
        end
      end
    end
  end

  def get_best_move(board, next_player, depth = 0, best_score = {})
    empty_squares = []
    best_move = nil
    board.each do |square|
      if square != COMPUTER_MARKER && square != HUMAN_MARKER
        empty_squares << square
      end
    end
    empty_squares.each do |squares|
      board[squares.to_i] = @computer
      if game_is_over(board)
        best_move = squares.to_i
        board[squares.to_i] = squares
        return best_move
      else
        board[squares.to_i] = @human
        if game_is_over(board)
          best_move = squares.to_i
          board[squares.to_i] = squares
          return best_move
        else
          board[squares.to_i] = squares
        end
      end
    end
    if best_move
      return best_move
    else
      n = rand(0..empty_squares.count)
      return empty_squares[n].to_i
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
    board.all? { |square| square == COMPUTER_MARKER || square == HUMAN_MARKER }
  end

end
