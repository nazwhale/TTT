require_relative './lib/game_maker'
require_relative './lib/ui'
require_relative './lib/validator'

game_maker = GameMaker.new(UI.new, Validator.new)
game_maker.new_game
