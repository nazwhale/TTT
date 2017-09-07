class Computer

  attr_reader :symbol

  MIDDLE_SQUARE = "4"

  def initialize(symbol)
    @symbol = symbol
    @opponent = nil
  end

  def get_move(game)
    move = get_best_move(game)
    game.current_player = self
    move
  end

  def get_best_move(game, depth=0, best_score={})
    return -1 if game.board.win?(game.get_opponent(self))
    return 1 if game.board.win?(self)
    return 0 if game.board.tie?(game.player1, game.player2)

    get_empty_squares(game.board).each do |space|

      game.switch_player
      game.board.state[space.to_i] = game.get_opponent(game.current_player).symbol

      p best_score
      best_score[space] = -1 * get_best_move(game, depth + 1, {})
      reset_square(game.board, space)
    end

    best_move = best_score.max_by { |key, value| value }[0]
    highest_minimax_score = best_score.max_by { |key, value| value }[1]

    if depth == 0
      best_move.to_i
    elsif depth > 0
      highest_minimax_score.to_i
    end
  end

  private

  def middle_square_taken?(board)
    board.state[4] == MIDDLE_SQUARE
  end

  def game_ending_move(board, empty_squares, player)
    best_move = nil
    empty_squares.each do |square|
      index = square.to_i
      board.state[index] = player.symbol
      best_move = index if board.win?(player)
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
