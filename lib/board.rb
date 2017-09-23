class Board

  EMPTY_BOARD = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
  CORNERS = [0, 2, 6, 8]
  attr_reader :state
  attr_writer :state

  def initialize
    @state = EMPTY_BOARD
  end

  def occupied?(index)
    index.to_s != @state[index.to_i]
  end

  def empty?
    @state.none? { |square| occupied?(@state.index(square)) }
  end

  def game_over?(player1, player2)
    anyone_won?(player1, player2) || tie?(player1, player2)
  end

  def tie?(player1, player2)
    anyone_won?(player1, player2) ? false : board_full?
  end

  def win?(player)
    win_scenarios.any? { |line| line.count(player.symbol) == 3 }
  end

  def get_corners
    CORNERS
  end

  private

  def win_scenarios
    rows + columns + diagonals
  end

  def rows
    [
      [@state[0], @state[1], @state[2]],
      [@state[3], @state[4], @state[5]],
      [@state[6], @state[7], @state[8]]
    ]
  end

  def columns
    rows.transpose
  end

  def diagonals
    [
      [@state[0], @state[4], @state[8]],
      [@state[2], @state[4], @state[6]]
    ]
  end

  def anyone_won?(player1, player2)
    win?(player1) || win?(player2)
  end

  def board_full?
    @state.all? { |square| occupied?(@state.index(square)) }
  end
end
