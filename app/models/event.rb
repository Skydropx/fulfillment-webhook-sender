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

  # After an event is created, is necessary to create a message for each webhook
  after_create :create_messages

  def create_messages
    Webhook.where(topic: topic, external_user_id: external_user_id).each do |webhook|
      Message.create!(event_id: self.id, webhook_id: webhook.id, attempts: 0)
    end
  end

end
