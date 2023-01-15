# frozen_string_literal: true

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
