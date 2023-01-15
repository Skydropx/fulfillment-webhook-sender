require 'rails_helper'

class KafkaMessageDouble
  def topic
    'topic'
  end

  def value
    {
      'id' => 1,
      'name' => 'name'
    }.to_json
  end

  def offset
    0
  end

  def partition
    0
  end

  def key
    'key'
  end
end

class TopicMapper
  def initialize(message)
    @message = message
  end

  def map
    {
      user_id: 1,
      message: @message
    }
  end
end

class KafkaConfig
  def self.topics
    ['topic', 'order_created']
  end
end

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
