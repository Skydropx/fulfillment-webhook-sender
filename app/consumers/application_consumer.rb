# frozen_string_literal: true

# ApplicationConsumer
class ApplicationConsumer
  def process_default(message)
    process(message)
    mapped_data = "#{topic}_mapper".classify.constantize.new(value).map
    # Store Event
    Event.create!(
      topic:,
      external_user_id: mapped_data[:user_id],
      payload: mapped_data.except(:user_id)
    )
  end

  private

  attr_reader :topic, :value, :key, :partition, :offset

  def process(message)
    @topic = message.topic.gsub(/^#{KafkaConfig.prefix}/, '')
    @value = JSON.parse message.value
    @key = message.key
    @partition = message.partition
    @offset = message.offset
  end
end
