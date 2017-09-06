class Computer

  attr_reader :symbol

  MIDDLE_SQUARE = "4"

  def initialize(symbol)
    @symbol = symbol
    @opponent = nil
  end

  def get_move(board, opponent)
    middle_square_taken?(board) ? MIDDLE_SQUARE.to_i : get_best_move(board, opponent)
  end

  def get_best_move(board, opponent)
    empty_squares = get_empty_squares(board)
    best_move = game_ending_move(board, empty_squares, @symbol)
    best_move = game_ending_move(board, empty_squares, opponent.symbol) unless best_move
    best_move = make_random_move(empty_squares) unless best_move
    best_move
  end

  private

  def middle_square_taken?(board)
    board.state[4] == MIDDLE_SQUARE
  end

  def game_ending_move(board, empty_squares, symbol)
    best_move = nil
    empty_squares.each do |square|
      index = square.to_i
      board.state[index] = symbol
      best_move = index if board.game_won?
      reset_square(board, square)
    end
    best_move
  end

  def reset_square(board, square)
    board.state[square.to_i] = square
  end

  def make_random_move(empty_squares)
    random_index = rand(empty_squares.count - 1)
    empty_squares[random_index].to_i
  end

  def get_empty_squares(board)
    empty_squares = []
    board.state.each_with_index do |square, index|
      empty_squares << square unless board.occupied?(index)
    end
    empty_squares
  end

end
