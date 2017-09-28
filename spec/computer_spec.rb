require 'computer'
require 'human'
require 'game'

describe Computer do
  subject(:computer_x) { described_class.new("X") }
  let(:board) { Board.new(3) }
  let(:opponent_o) { Human.new("O") }
  let(:player_1_game) { Game.new(computer_x, opponent_o, board) }
  let(:computer_o) { described_class.new("O") }
  let(:opponent_x) { Human.new("X") }
  let(:player_2_game) { Game.new(opponent_x, computer_o, board) }

  describe '#initialize' do
    it 'has a symbol' do
      expect(computer_x.symbol).to eq "X"
    end
  end

  describe '#get_move' do
    it 'calls get_best_move if the board is not empty' do
      player_1_game.board.state = [nil, "X", nil, nil, nil, nil, nil, nil, nil]
      allow(computer_x).to receive(:get_best_move)
      computer_x.get_move(player_1_game)
      expect(computer_x).to have_received(:get_best_move).once
    end
  end

  describe '#get_best_move' do
    context 'playing as X' do
      before do
        player_1_game.current_player = computer_x
      end

      it 'seizes the win' do
        player_1_game.board.state = [nil, "X", nil, "O", "X", "O", nil, nil, nil]
        expect(computer_x.get_best_move(player_1_game)).to eq 7
      end

      it 'prevents a loss', :focus => true do
        player_1_game.board.state = ["X", nil, nil, "O", "O", nil, nil, nil, "X"]
        expect(computer_x.get_best_move(player_1_game)).to eq 5
      end

      it 'seizes the win, even when within one move of losing' do
        player_1_game.board.state = ["X", "X", nil, nil, "O", "O", nil, nil, nil]
        expect(computer_x.get_best_move(player_1_game)).to eq 2
      end

      it 'makes a random move if no win or loss is in sight' do
        player_1_game.board.state = ["X", "O", "O", "O", "X", "X", nil, nil, "O"]
        expect(computer_x.get_best_move(player_1_game)).to eq(6).or(eq(7))
      end

      it 'chooses to win rather than block - player 1' do
        player_1_game.board.state = ["X",nil,"X",nil,nil,nil,"O",nil,"O"]
        expect(computer_x.get_best_move(player_1_game)).to eq 1
      end
    end

    context 'playing as O' do
      before do
        player_2_game.current_player = computer_o
      end

      it 'chooses to win rather than block - player 2'do
        player_2_game.board.state = ["X",nil,"X","X",nil,nil,"O",nil,"O"]
        expect(computer_o.get_best_move(player_2_game)).to eq 7
      end

      it 'siezes the win - player 2' do
        player_2_game.board.state = ["X",nil,nil,"X","O",nil,"O",nil,nil]
        expect(computer_o.get_best_move(player_2_game)).to eq 2
      end

      it "blocks a win - player 2" do
        player_2_game.board.state = [nil,nil,nil,"O",nil,nil,"X","X",nil]
        expect(computer_o.get_best_move(player_2_game)).to eq 8
      end
    end
  end
end
