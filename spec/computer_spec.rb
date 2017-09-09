require 'computer'
require 'human'
require 'game'

describe Computer do
  subject(:computer) { described_class.new("X") }
  let(:opponent) { Human.new("O") }
  let(:game) { Game.new(computer, opponent) }
  let(:computer_o) { described_class.new("O") }
  let(:opponent_x) { Human.new("X") }
  let(:player_2_game) { Game.new(opponent_x, computer_o) }

  describe '#initialize' do
    it 'has a symbol' do
      expect(computer.symbol).to eq "X"
    end
  end

  describe '#get_best_move' do
    context 'playing as X' do
      before do
        game.current_player = computer
      end

      it 'seizes the win' do
        game.board.state = ["0", "X", "2", "O", "X", "O", "6", "7", "8"]
        expect(computer.get_best_move(game)).to eq 7
      end

      it 'prevents a loss', :focus => true do
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

      it 'chooses to win rather than block - player 1' do
        game.board.state = ["X","1","X","3","4","5","O","7","O"]
        expect(computer.get_best_move(game)).to eq 1
      end
    end

    context 'playing as O' do
      before do
        player_2_game.current_player = computer_o
      end

      it 'chooses to win rather than block - player 2'do
        player_2_game.board.state = ["X","1","X","X","4","5","O","7","O"]
        expect(computer_o.get_best_move(player_2_game)).to eq 7
      end

      it 'siezes the win - player 2' do
        player_2_game.board.state = ["X","1","2","X","O","5","O","7","8"]
        expect(computer_o.get_best_move(player_2_game)).to eq 2
      end

      it "blocks a win - player 2" do
        player_2_game.board.state = ["0","1","2","O","4","5","X","X","8"]
        expect(computer_o.get_best_move(player_2_game)).to eq 8
      end

    end
  end
end
