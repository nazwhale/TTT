require 'human'

describe Human do

  subject(:human) { described_class.new }

  describe '#initialize' do
    it 'has a marker' do
      expect(human.marker).to eq Human::MARKER
    end
  end

  describe '#get_move' do
    it 'receives and returns user input' do
      allow($stdin).to receive(:gets).and_return(3)
      move = $stdin.gets
      expect(move).to eq 3
    end
  end

end
