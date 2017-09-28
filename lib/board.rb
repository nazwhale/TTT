class Board

  EMPTY_SQUARE = nil
  attr_reader :state, :number_of_rows
  attr_writer :state

  def initialize(number_of_rows)
    @number_of_rows = number_of_rows
    @state = Array.new(@number_of_rows * @number_of_rows)
  end

  def occupied?(index)
    @state[index.to_i] != EMPTY_SQUARE
  end

  def empty?
    @state.all? { |square| square == EMPTY_SQUARE } 
  end

  def game_over?(player1, player2)
    anyone_won?(player1, player2) || tie?(player1, player2)
  end

  def tie?(player1, player2)
    board_full? && !anyone_won?(player1, player2)
  end

  def win?(player)
    win_scenarios.any? { |line| line.count(player.symbol) == root_board_size }
  end

  private

  def board_size
    @state.length
  end

  def root_board_size
    Math.sqrt(board_size)
  end

  def win_scenarios
    rows + columns + left_diagonal + right_diagonal
  end

  def rows
    @state.each_slice(root_board_size).to_a
  end

  def columns
    rows.transpose
  end

  def left_diagonal
    [rows.collect.with_index { |row, index| row[index] }]
  end

  def right_diagonal
    [rows.collect.with_index { |row, index| row.reverse[index] }]
  end

  def anyone_won?(player1, player2)
    win?(player1) || win?(player2)
  end

  def board_full?
    @state.none? { |square| square == EMPTY_SQUARE } 
  end
end
