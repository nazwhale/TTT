require_relative './lib/game_maker'
require_relative './lib/ui'

game_maker = GameMaker.new(UI.new)
game_maker.new_game
