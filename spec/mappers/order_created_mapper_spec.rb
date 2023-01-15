# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderCreatedMapper do
  describe '#map' do
    context 'with valid params' do
      let(:event) do
        {
          'id' => '123',
          'account_id' => '456',
          'created_at' => '2019-01-01T00:00:00Z',
          'products' => [
            {
              'id' => '789',
              'name' => 'Product 1',
              'price' => 10.0,
              'quantity' => 1
            },
            {
              'id' => '101',
              'name' => 'Product 2',
              'price' => 20.0,
              'quantity' => 2
            }
          ],
          'status' => 'open'
        }
      end

      let(:expected_keys) { %i[order_id user_id created_at products status] }

      it 'returns the expected keys' do
        expect(described_class.new(event).map.keys).to eq(expected_keys)
      end

      it 'returns the expected values' do
        expect(described_class.new(event).map.values).to eq([
          '123',
          '456',
          '2019-01-01T00:00:00Z',
          [
            {
              'id' => '789',
              'name' => 'Product 1',
              'price' => 10.0,
              'quantity' => 1
            },
            {
              'id' => '101',
              'name' => 'Product 2',
              'price' => 20.0,
              'quantity' => 2
            }
          ],
          'open'
        ])
      end
    end
  end
end
