class Human

  attr_reader :marker

  MARKER = "O"

  def initialize
    @marker = MARKER
  end

  # gets input (Human)
  # checks if square is free (ask Board.occupied?(square))
  # if not, gets input (Human)
  # places marker (Board.place_marker)

  def move
    get_move
  end

  def get_move
    gets.chomp.to_i
  end


end
