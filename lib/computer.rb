class Computer

  attr_reader :marker

  MARKER = "X"
  MIDDLE_SQUARE = "4"

  def initialize
    @marker = MARKER
  end

  def choose_square(board)
    board[4] == MIDDLE_SQUARE ? 4 : get_best_move(board)
  end

  def get_best_move(board)
    empty_squares = []
    best_move = nil

    #get array of available squares
    board.each do |square|
      unless square == "X" || square == "O"
        empty_squares << square
      end
    end

    empty_squares.each do |square|
      #if choosing the square results in a win, choose it
      board[square.to_i] = @marker
      if game_is_over(board)
        best_move = square.to_i
        board[square.to_i] = square
        return best_move
      else
        #if the other player choosing the square wins, choose it
        board[square.to_i] = "O"
        if game_is_over(board)
          best_move = square.to_i
          board[square.to_i] = square
          return best_move
        else
          #reset the square
          board[square.to_i] = square
        end
      end
    end

    #if no best_move found, make a random move
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

end
