class Validator

  def symbol_invalid?(ui, choice, opponent_symbol)
    if not_single_character(choice)
      ui.wrong_symbol_length
      true
    elsif choice == opponent_symbol
      ui.symbol_must_be_original
      true
    elsif is_an_integer?(choice)
      ui.symbol_cant_be_integer
      true
    else
      ui.choice_confirmation(choice)
      false
    end
  end

  def move_invalid?(board, choice)
    board.occupied?(choice) || choice == ""
  end

  private

  def is_an_integer?(choice)
    choice == "0" || choice.to_i != 0
  end

  def not_single_character(string)
    string.length != 1
  end

end
