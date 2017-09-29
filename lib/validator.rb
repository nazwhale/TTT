class Validator

  def symbol_invalid?(choice, opponent_symbol)
    not_single_character?(choice)              ||
    same_as_opponent?(choice, opponent_symbol) ||
    is_an_integer?(choice)
  end

  def move_invalid?(board, move)
    board.occupied?(move)      || 
    not_in_board?(board, move) || 
    empty_string?(move)        || 
    !is_an_integer?(move)
  end

  private

  def is_an_integer?(choice)
    choice == "0" || choice.to_i != 0
  end

  def not_single_character?(string)
    string.length != 1
  end
  
  def same_as_opponent?(choice, opponent_symbol)
    choice == opponent_symbol
  end

  def not_in_board?(board, move)
    move.to_i >= board.state.length
  end

  def empty_string?(move)
    move == ""
  end
end
