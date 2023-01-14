# frozen_string_literal: true

# ApplicationConsumer
class ApplicationConsumer
  def process_default(message)
    process(message)
    mapped_data = "#{topic}_mapper".classify.constantize.new(value).map
    # Store Event
    # Event.create(
    #  topic: topic,
    #  user: mapped_data[:user_id],
    #  data: mapped_data
    #  )
    #
  end

  private

  attr_reader :topic, :value, :key, :partition, :offset

  def process(message)
    @topic = message.topic.gsub(/^#{KafkaTopic.prefix}/, '')
    @value = message.value
    @key = message.key
    @partition = message.partition
    @offset = message.offset
  end
end
