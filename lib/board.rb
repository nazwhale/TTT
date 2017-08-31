
class Board

  EMPTY_BOARD = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
  attr_reader :state
  attr_writer :state

  def initialize
    @state = EMPTY_BOARD
  end

  def occupied?(square)
    state[square.to_i] == "X" || state[square.to_i] == "O"
  end

  def game_over?
    game_won? || tie?
  end

  def tie?
    @state.all? { |square| occupied?(square) }
  end

  def game_won?
    all_wins.any? { |line| line.uniq.length == 1 }
  end

  private

  def all_wins
    row_wins + column_wins + diagonal_wins
  end

  def row_wins
    [
      [@state[0], @state[1], @state[2]],
      [@state[3], @state[4], @state[5]],
      [@state[6], @state[7], @state[8]]
    ]
  end

  def column_wins
    row_wins.transpose
  end

  def diagonal_wins
    [
      [@state[0], @state[4], @state[8]],
      [@state[2], @state[4], @state[6]]
    ]
  end
end
