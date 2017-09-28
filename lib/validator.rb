class Validator

  def symbol_invalid?(ui, choice, opponent_symbol)
    if not_single_character?(choice)
      ui.wrong_symbol_length
      true
    elsif same_as_opponent?(choice, opponent_symbol)
      ui.symbol_must_be_original
      true
    elsif is_an_integer?(choice)
      ui.symbol_cant_be_integer
      true
    else
      ui.choice_confirmation(choice)
    end
  end

  def move_invalid?(ui, board, move)
    if invalid_move_scenario?(board, move)
      ui.invalid_choice_message
      true
    end
  end

  private

  def invalid_move_scenario?(board, move)
    board.occupied?(move)      || 
    not_in_range?(board, move) || 
    empty_string?(move)        || 
    !is_an_integer?(move)
  end

  def is_an_integer?(choice)
    choice == "0" || choice.to_i != 0
  end

  def not_single_character?(string)
    string.length != 1
  end
  
  def same_as_opponent?(choice, opponent_symbol)
    choice == opponent_symbol
  end

  def not_in_range?(board, move)
    move.to_i >= board.state.length
  end

  def empty_string?(move)
    move == ""
  end
end
