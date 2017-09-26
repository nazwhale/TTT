class Human

  attr_reader :symbol

  def initialize(symbol)
    @symbol = symbol
  end

  def get_move(game)
    choice = nil
    until choice
      choice = gets.chomp
      if choice_invalid?(game.board, choice)
        choice = nil
      end
    end
    choice.to_i
  end

  def choice_invalid?(board, choice)
    board.occupied?(choice) || choice == ""
  end

end
