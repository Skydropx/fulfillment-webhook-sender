# frozen_string_literal: true

require 'rails_helper'
require './spec/doubles/kafka_message_double'
require './spec/doubles/topic_mapper'

RSpec.describe ApplicationConsumer do
  describe '#process_default' do
    let(:message) { KafkaMessageDouble.new }

    context 'with a valid message' do
      it 'creates a new event' do
        expect { subject.process_default(message) }.to change(Event, :count).by(1)
      end
    end
  end
end
