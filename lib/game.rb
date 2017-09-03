require_relative 'messages'
require_relative 'computer'
require_relative 'human'
require_relative 'board'

class Game

  attr_reader :player1, :player2, :board, :current_player

  def initialize(player1, player2, board = Board.new)
    @player1 = player1
    @player2 = player2
    @board = board
    @current_player = @player1
  end

  def play
    until @board.game_over?
      show_current_board
      make_move(@current_player)
      switch_player
    end
    show_current_board
    game_over_message
  end

  private

  def switch_player
    @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
  end

  def human_player?(player)
    player.class == Human
  end

  def make_move(player)
    human_player?(player) ? make_human_move(player) : make_computer_move(player)
  end

  def make_human_move(player)
    Messages.prompt_move
    choice = nil
    until choice
      choice = player.get_move
      choice = nil if @board.occupied?(choice)
    end
    place_symbol(player, choice)
    puts "You chose: " + choice.to_s
  end

  def make_computer_move(player)
    Messages.computer_thinking
    unless @board.game_over?
      choice = player.get_move(@board, get_opponent)
      place_symbol(player, choice)
    end
    puts "The Computer chose: " + choice.to_s
  end

  def get_opponent
    switch_player
    opponent = @current_player
    switch_player
    opponent
  end

  def place_symbol(player, choice)
    @board.state[choice] = player.symbol
  end

  def choose_symbol_prompt(player)
    Messages.choose_symbol_prompt(player)
  end

  def show_current_board
    Messages.print_board(board)
  end

  def game_over_message
    switch_player
    @board.tie? ? Messages.tie_message : Messages.win_message(@current_player)
    Messages.see_you_again
  end

end
