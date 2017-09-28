class Computer

  MAX_DEPTH = 6
  attr_reader :symbol

  def initialize(symbol)
    @symbol = symbol
    @opponent = nil
  end

  def get_move(game)
    move = get_best_move(game)
    game.current_player = self
    move
  end

  def get_best_move(game)
    @best_score = {}
    negamax(game)
    pick_best_move(@best_score)
  end

  private

  def negamax(game, depth = 0, alpha = -100, beta = 100, color = 1)
    return 0 if depth > MAX_DEPTH
    return color * score(game, depth) if game.board.game_over?(game.player1, game.player2)

    max = -100

    get_empty_squares(game.board).each do |square|
      depth.even? ? game.current_player = self : game.current_player = game.get_opponent(self)
      game.place_symbol(game.current_player, square)
      
      negamax_value = -negamax(game, depth + 1, -beta, -alpha, -color)

      reset_square(game.board, square)
      game.switch_player
      
      max = [max, negamax_value].max
      @best_score[square] = max if depth == 0
      
      alpha = [alpha, negamax_value].max
      return alpha if alpha >= beta
    end

    max
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

  def pick_best_move(scores)
    scores.max_by { |key, value| value }[0]
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
