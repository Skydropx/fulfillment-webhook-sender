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
