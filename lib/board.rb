
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
    [@state[0], @state[1], @state[2]].uniq.length == 1 ||
    [@state[3], @state[4], @state[5]].uniq.length == 1 ||
    [@state[6], @state[7], @state[8]].uniq.length == 1 ||
    [@state[0], @state[3], @state[6]].uniq.length == 1 ||
    [@state[1], @state[4], @state[7]].uniq.length == 1 ||
    [@state[2], @state[5], @state[8]].uniq.length == 1 ||
    [@state[0], @state[4], @state[8]].uniq.length == 1 ||
    [@state[2], @state[4], @state[6]].uniq.length == 1
  end

end
