class Human

  attr_reader :symbol

  SYMBOL = "O"

  def initialize
    @symbol = SYMBOL
  end

  def get_move
    gets.chomp.to_i
  end

end
