require 'computer'

describe Computer do

  subject(:computer) { described_class.new("X") }
  let(:opponent) { Human.new("O") }
  let(:game) { Game.new(computer, opponent) }

  describe '#initialize' do
    it 'has a symbol' do
      expect(computer.symbol).to eq "X"
    end
  end

  describe '#get_move' do
  end

  describe '#get_best_move' do
    it 'seizes the win' do
      game.board.state = ["0", "X", "2", "O", "X", "O", "6", "7", "8"]
      expect(computer.get_best_move(game)).to eq 7
    end

    it 'prevents a loss' do
      game.board.state = ["X", "1", "2", "O", "O", "5", "6", "7", "X"]
      expect(computer.get_best_move(game)).to eq 5
    end

    it 'seizes the win, even when within one move of losing' do
      game.board.state = ["X", "X", "2", "3", "O", "O", "6", "7", "8"]
      expect(computer.get_best_move(game)).to eq 2
    end

    it 'makes a random move if no win or loss is in sight' do
      game.board.state = ["X", "O", "O", "O", "X", "X", "6", "7", "O"]
      expect(computer.get_best_move(game)).to eq(6).or(eq(7))
    end
  end

end
