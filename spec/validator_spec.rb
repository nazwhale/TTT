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

    context 'valid' do
      it 'returns true' do
        expect(validator.symbol_valid?(ui, 'X', 'O')).to eq true
      end
    end

    context 'invalid' do
      it 'returns false if symbol is more than 1 character' do
        expect(validator.symbol_valid?(ui, 'asdf', 'O')).to eq false
      end

      it 'returns false if symbol is blank' do
        expect(validator.symbol_valid?(ui, '', 'O')).to eq false
      end

      it 'returns false if symbol is an integer' do
        expect(validator.symbol_valid?(ui, '2', 'O')).to eq false
      end

      it 'returns false if symbol is the same as the opponent' do
        expect(validator.symbol_valid?(ui, 'O', 'O')).to eq false
      end
    end

  end

end
