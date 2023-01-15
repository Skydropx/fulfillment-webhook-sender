class WebhookSenderJob < ApplicationJob
  def perform(message_id)
    message = Message.find(message_id)
    webhook = message.webhook
    event = message.event
    WebhookSender.new(webhook, message, event).call
  end
end
