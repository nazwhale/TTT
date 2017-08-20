require_relative 'output_messages'
require_relative 'computer'
require_relative 'human'
require_relative 'board'

class Game

  attr_reader :board, :computer, :human

  def initialize
    @board = Board.new
    @computer = Computer.new
    @human = Human.new
  end

  def play
    show_current_board
    # loop through until the game is won or tied
    until @board.game_over? || @board.tie?

      humans_choice = nil
      #if choice taken, ask again
      until humans_choice
        humans_choice = gets.chomp.to_i
        humans_choice = nil if @board.occupied?(@board.state[humans_choice])
      end

      @board.state[humans_choice] = @human.marker

      unless @board.game_over? || @board.tie?
        computers_choice = @computer.get_square(@board)
        @board.state[computers_choice] = @computer.marker
      end

      show_current_board
    end
    Messages.game_over_message
  end

  def show_current_board
    puts "#{@board.state[0]} | #{@board.state[1]} | #{@board.state[2]}"
    Messages.line
    puts "#{@board.state[3]} | #{@board.state[4]} | #{@board.state[5]}"
    Messages.line
    puts "#{@board.state[6]} | #{@board.state[7]} | #{@board.state[8]}"
    Messages.move_prompt
  end

end
