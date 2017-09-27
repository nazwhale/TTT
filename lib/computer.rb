class Computer

  attr_reader :symbol

  def initialize(symbol)
    @symbol = symbol
    @opponent = nil
  end

  def get_move(game)
    game.board.empty? ? move = choose_corner(game) : move = get_best_move(game)
    game.current_player = self
    move
  end

  def get_best_move(game, depth = 0, move_scores = {})
    return score(game, depth) if game.board.game_over?(game.player1, game.player2)

    get_empty_squares(game.board).each do |square|
      depth.even? ? game.current_player = self : game.current_player = game.get_opponent(self)
      game.place_symbol(game.current_player, square)
      move_scores[square] = get_best_move(game, depth + 1, {})

      reset_square(game.board, square)
      game.switch_player
    end

    if depth == 0
      pick_best_move(move_scores)
    elsif depth > 0
      game.current_player == self ? minimise_score(move_scores) : maximise_score(move_scores)
    end
  end

  private

  def choose_corner(game)
    corners = game.board.get_corners  # DEMETER
    make_random_move(corners)
  end

  def score(game, depth)
    if game.board.win?(self)
      100 / depth
    elsif game.board.win?(game.get_opponent(self))
      -100 / depth
    elsif game.board.tie?(game.player1, game.player2)
      0
    end
  end

  def pick_best_move(move_scores)
    move_scores.max_by { |key, value| value }[0]
  end

  def maximise_score(move_scores)
    move_scores.max_by { |key, value| value }[1]
  end

  def minimise_score(move_scores)
    move_scores.min_by { |key, value| value }[1]
  end

  def reset_square(board, square)
    board.state[square] = nil
  end

  def make_random_move(squares)
    random_index = rand(squares.count - 1)
    squares[random_index]
  end

  def get_empty_squares(board)
    empty_squares = []
    board.state.each_with_index do |square, index|
      empty_squares << index unless board.occupied?(index)
    end
    empty_squares
  end
end
