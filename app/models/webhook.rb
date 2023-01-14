class Webhook < ApplicationRecord
  # Enum for mapping each topic on KafkaConfig.topics with an integer. 
  enum topic: KafkaConfig.topics.each_with_index.map { |topic, index| [topic, index] }.to_h
end
