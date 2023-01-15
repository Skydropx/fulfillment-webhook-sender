# frozen_string_literal: true

# == Schema Information
#
# Table name: messages
#
#  id              :bigint           not null, primary key
#  event_id        :bigint           not null
#  webhook_id      :bigint           not null
#  attempts        :integer
#  delivery_status :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

# Each message is related with an event and a webhook.
class Message < ApplicationRecord
  belongs_to :event
  belongs_to :webhook

  enum delivery_status: { pending: 0, sent: 1, failed: 2 }

  # The combination of event_id and webhook_id should be unique.
  validates :event_id, uniqueness: { scope: :webhook_id }

  # After a message is created, is necessary to send it to the webhook sender job.
  after_create :send_message

  def send_message
    WebhookSenderJob.perform_later(id)
  end
end
