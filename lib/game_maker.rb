require_relative 'game'

class GameMaker

  def play
    Game.new(Human.new("O"), Computer.new("X")).play
  end

end
