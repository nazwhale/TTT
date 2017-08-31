class Human

  attr_reader :symbol

  def initialize(symbol)
    @symbol = symbol
  end

  def get_move
    gets.chomp.to_i
  end

end
