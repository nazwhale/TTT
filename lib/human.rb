class Human

  attr_reader :marker

  MARKER = "O"

  def initialize
    @marker = MARKER
  end

  def get_move
    gets.chomp.to_i
  end

end
