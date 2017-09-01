require 'game_maker'

describe GameMaker do

  subject(:game_maker) { described_class.new }
  let(:player1) { Human.new("X") }
  let(:player2) { Computer.new("O") }
  let(:game) { Game.new(player1, player2) }

  describe '#initialize' do
    it 'has a board' do
      expect(game_maker.game).to be nil
    end
  end

  describe '#new_game' do
    it 'calls choose_game_type' do
      allow(game_maker).to receive(:choose_game_type)
      game_maker.instance_variable_set(:@game, game)
      allow(game_maker.game).to receive(:play)
      game_maker.new_game
      expect(game_maker).to have_received(:choose_game_type)
    end
  end

  describe '#choose_game_type' do
    it 'chooses two human players' do
      allow(game_maker).to receive(:gets).and_return('1')
      allow(game_maker).to receive(:human_vs_human)
      allow(Messages).to receive(:prompt_game_type)
      game_maker.choose_game_type
      expect(game_maker).to have_received(:human_vs_human)
    end

    it 'chooses human vs computer' do
      allow(game_maker).to receive(:gets).and_return('2')
      allow(game_maker).to receive(:human_vs_computer)
      allow(Messages).to receive(:prompt_game_type)
      game_maker.choose_game_type
      expect(game_maker).to have_received(:human_vs_computer)
    end

    it 'chooses two computer players' do
      allow(game_maker).to receive(:gets).and_return('3')
      allow(game_maker).to receive(:computer_vs_computer)
      allow(Messages).to receive(:prompt_game_type)
      game_maker.choose_game_type
      expect(game_maker).to have_received(:computer_vs_computer)
    end
  end

end

