require 'rails_helper'
require './spec/doubles/kafka_message_double'

RSpec.describe OrderCreatedConsumer do
  describe '#consume' do
    let(:message) { KafkaMessageDouble.new }

    context 'with a valid message' do
      it 'creates a new event' do
        expect { subject.consume(message) }.to change(Event, :count).by(1)
      end
    end
  end
end
