class Computer

  MAX_DEPTH = 6
  attr_reader :symbol

  def initialize(symbol)
    @symbol = symbol
    @opponent = nil
  end

  def get_move(game)
    move = get_best_move(game, self)
    game.current_player = self
    move
  end

  def get_best_move(game, this_player)
    @best_score = {}
    negamax(game, this_player)
    pick_best_move(@best_score)
  end

  private

  def negamax(game, this_player, depth = 0, alpha = -100, beta = 100, color = 1)
    return 0 if depth > MAX_DEPTH
    return color * score(game, depth, this_player) if game.board.game_over?(game.player1, game.player2)

    max = -100

    get_empty_squares(game.board).each do |square|
      depth.even? ? game.current_player = this_player : game.current_player = game.get_opponent(this_player)
      game.place_symbol(game.current_player, square)
      
      negamax_value = -negamax(game, this_player, depth + 1, -beta, -alpha, -color)

      reset_square(game.board, square)
      game.switch_player
      
      max = [max, negamax_value].max
      @best_score[square] = max if depth == 0
      
      alpha = [alpha, negamax_value].max
      return alpha if alpha >= beta
    end

    max
  end

  def score(game, depth, this_player)
    if game.board.win?(this_player)
      100 / depth
    elsif game.board.win?(game.get_opponent(this_player))
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

  def get_empty_squares(board)
    empty_squares = []
    board.state.each_with_index do |square, index|
      empty_squares << index unless board.occupied?(index)
    end
    empty_squares
  end
end
