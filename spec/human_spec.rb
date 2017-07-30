require 'human'

describe Human do

  subject(:human) { described_class.new }

  describe '#initialize' do
    it 'has a marker' do
      expect(human.marker).to eq Human::MARKER
    end
  end

end
