require 'game'

describe Game do

  subject(:game) { described_class.new }

  describe '#initialize' do
    it 'has a board' do
      expect(game.board).to be_a Board
    end

    it 'has an instance of computer' do
      expect(game.computer).to be_a Computer
    end

    it 'has an instance of human' do
      expect(game.human).to be_a Human
    end
  end

     # it 'selects an empty square' do
     #   board = ["0", "1", "X", "3", "4", "O", "X", "7", "8"]
     #   #stub user input
     #   allow($stdin).to receive(:gets).and_return('1')
     #   name = $stdin.gets

       # expect(name).to eq('food')

       # human.get_square(board)
       # expect(human.get_square(board)).to eq
     # end

     # it 'selects a taken square' do
     #   board = ["0", "1", "X", "3", "4", "O", "X", "7", "8"]
     #   #stub user input
     #   human.get_square(board)
     #   expect(human.get_square(board)).to
     # end

end
