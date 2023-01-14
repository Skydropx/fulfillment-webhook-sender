# == Schema Information
#
# Table name: events
#
#  id               :bigint           not null, primary key
#  external_user_id :string
#  payload          :json
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  topic            :integer
#

# Stores events from the external service.
# The events are ready to send to the related webhooks.
class Event < ApplicationRecord
  # Enum for mapping each topic on KafkaConfig.topics with an integer. 
  enum topic: KafkaConfig.topics.each_with_index.map { |topic, index| [topic, index] }.to_h
  has_many :messages
  has_many :webhooks, through: :messages
end
