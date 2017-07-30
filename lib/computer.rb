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
    best_move = nil
    empty_squares = get_empty_squares(board)

    empty_squares.each do |square|
      square_index = square.to_i

      board[square_index] = @marker
      return square_index if game_is_over(board)
      board[square.to_i] = "O"
      return square_index if game_is_over(board)

      reset_square(board, square)
    end
    best_move ? best_move : make_random_move(empty_squares)
  end

  private

  def reset_square(board, square)
    board[square.to_i] = square
  end

  def make_random_move(empty_squares)
    random_index = rand(empty_squares.count - 1)
    empty_squares[random_index].to_i
  end

  def get_empty_squares(board)
    empty_squares = []

    board.each do |square|
      empty_squares << square unless square == "X" || square == "O"
    end

    empty_squares
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
