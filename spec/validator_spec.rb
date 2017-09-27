require 'validator'

describe Validator do

  subject(:validator) { described_class.new }
  subject(:ui) { UI.new }

  describe '#symbol_valid?' do
    before do
      allow(ui).to receive(:wrong_symbol_length)
      allow(ui).to receive(:symbol_must_be_original)
      allow(ui).to receive(:symbol_cant_be_integer)
      allow(ui).to receive(:choice_confirmation)
    end

    context 'invalid' do
      it 'returns false if valid' do
        expect(validator.symbol_invalid?(ui, 'X', 'O')).to eq false
      end
    end

    context 'invalid' do
      it 'returns true if symbol is more than 1 character' do
        expect(validator.symbol_invalid?(ui, 'asdf', 'O')).to eq true
      end

      it 'returns true if symbol is blank' do
        expect(validator.symbol_invalid?(ui, '', 'O')).to eq true
      end

      it 'returns true if symbol is an integer' do
        expect(validator.symbol_invalid?(ui, '2', 'O')).to eq true
      end

      it 'returns true if symbol is the same as the opponent' do
        expect(validator.symbol_invalid?(ui, 'O', 'O')).to eq true
      end
    end
  end

  describe '#move_invalid' do
    it 'returns false if valid' do
      board = double('board')
      allow(board).to receive(:occupied?).and_return(false)
      expect(validator.move_invalid?(board, "1")).to eq false
    end

    it 'rejects an empty string' do
      board = double('board')
      allow(board).to receive(:occupied?).and_return(false)
      expect(validator.move_invalid?(board, "")).to eq true
    end

    it 'rejects an occupied square' do
      board = double('board')
      allow(board).to receive(:occupied?).and_return(true)
      expect(validator.move_invalid?(board, "0")).to eq true
    end
  end
end
