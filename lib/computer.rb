class Computer

  attr_reader :marker

  MARKER = "X"
  MIDDLE_SQUARE = "4"

  def initialize
    @marker = MARKER
  end

  def choose_square(board)
    board[4] == MIDDLE_SQUARE ? 4 : get_best_move(board, @marker)
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

end
