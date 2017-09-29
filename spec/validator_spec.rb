require 'validator'

describe Validator do

  subject(:validator) { described_class.new }

  describe '#symbol_valid?' do
    context 'invalid' do
      it 'returns false if valid' do
        expect(validator.symbol_invalid?('X', 'O')).to be_falsy
      end
    end

    context 'invalid' do
      it 'returns true if symbol is more than 1 character' do
        expect(validator.symbol_invalid?('asdf', 'O')).to eq true
      end

      it 'returns true if symbol is blank' do
        expect(validator.symbol_invalid?('', 'O')).to eq true
      end

      it 'returns true if symbol is an integer' do
        expect(validator.symbol_invalid?('2', 'O')).to eq true
      end

      it 'returns true if symbol is the same as the opponent' do
        expect(validator.symbol_invalid?('O', 'O')).to eq true
      end
    end
  end

  describe '#move_invalid' do
    context 'valid' do
      it 'returns false if valid' do
        board = double("board", :state => [nil, "X", nil, "O", "X", "O", nil, nil, nil])
        allow(board).to receive(:occupied?).and_return(false)
        expect(validator.move_invalid?(board, "1")).to be_falsy
      end
    end

    context 'invalid' do
      it 'rejects an empty string' do
        board = double("board", :state => [nil, "X", nil, "O", "X", "O", nil, nil, nil])
        allow(board).to receive(:occupied?).and_return(false)
        expect(validator.move_invalid?(board, "")).to eq true
      end

      it 'rejects an occupied square' do
        board = double("board", :state => [nil, "X", nil, "O", "X", "O", nil, nil, nil])
        allow(board).to receive(:occupied?).and_return(true)
        expect(validator.move_invalid?(board, "0")).to eq true
      end
      
      it 'rejects a non-integer' do
        board = double("board", :state => [nil, "X", nil, "O", "X", "O", nil, nil, nil])
        allow(board).to receive(:occupied?).and_return(false)
        expect(validator.move_invalid?(board, "t")).to eq true
      end
    end
  end
end
