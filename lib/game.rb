class Game

  attr_reader :board, :computer, :human

  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @computer = "X" # the computer's marker
    @human = "O" # the user's marker
  end

  def start_game
    # start by printing the board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} \n===+===+===\n #{@board[3]} | #{@board[4]} | #{@board[5]} \n===+===+===\n #{@board[6]} | #{@board[7]} | #{@board[8]} \n"
    puts "Enter [0-8]:"
    # loop through until the game was won or tied
    until game_is_over(@board) || tie(@board)
      get_human_spot
      if !game_is_over(@board) && !tie(@board)
        eval_board
      end
      puts " #{@board[0]} | #{@board[1]} | #{@board[2]} \n===+===+===\n #{@board[3]} | #{@board[4]} | #{@board[5]} \n===+===+===\n #{@board[6]} | #{@board[7]} | #{@board[8]} \n"
    end
    puts "Game over"
  end

  def get_human_spot
    spot = nil
    until spot
      spot = gets.chomp.to_i
      if @board[spot] != "X" && @board[spot] != "O"
        @board[spot] = @human
      else
        spot = nil
      end
    end
  end

  def eval_board
    spot = nil
    until spot
      if @board[4] == "4"
        spot = 4
        @board[spot] = @computer
      else
        spot = get_best_move(@board, @computer)
        if @board[spot] != "X" && @board[spot] != "O"
          @board[spot] = @computer
        else
          spot = nil
        end
      end
    end
  end

  def get_best_move(board, next_player, depth = 0, best_score = {})
    empty_squares = []
    best_move = nil
    board.each do |square|
      if square != "X" && square != "O"
        empty_squares << square
      end
    end
    empty_squares.each do |squares|
      board[squares.to_i] = @computer
      if game_is_over(board)
        best_move = squares.to_i
        board[squares.to_i] = squares
        return best_move
      else
        board[squares.to_i] = @human
        if game_is_over(board)
          best_move = squares.to_i
          board[squares.to_i] = squares
          return best_move
        else
          board[squares.to_i] = squares
        end
      end
    end
    if best_move
      return best_move
    else
      n = rand(0..empty_squares.count)
      return empty_squares[n].to_i
    end
  end

  def game_is_over(board)
    [board[0], board[1], board[2]].uniq.length == 1 ||
    [board[3], board[4], board[5]].uniq.length == 1 ||
    [board[6], board[7], board[8]].uniq.length == 1 ||
    [board[0], board[3], board[6]].uniq.length == 1 ||
    [board[1], board[4], board[7]].uniq.length == 1 ||
    [board[2], board[5], board[8]].uniq.length == 1 ||
    [board[0], board[4], board[8]].uniq.length == 1 ||
    [board[2], board[4], board[6]].uniq.length == 1
  end

  def tie(board)
    board.all? { |square| square == "X" || square == "O" }
  end

end
