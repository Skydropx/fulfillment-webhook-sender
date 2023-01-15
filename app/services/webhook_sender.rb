# frozen_string_literal: true

# This class is used to send a webhook to a given URL.
# It is used by the WebhookSenderJob.
# It requires a Webhook, a Message and an Event.
class WebhookSender
  def initialize(webhook, message, event)
    @webhook = webhook
    @message = message
    @event = event
  end

  def call 
    if post_request
      message.update!(delivery_status: 'sent', attempts: message.attempts + 1)
    else
      message.update!(delivery_status: 'failed', attempts: message.attempts + 1)
    end
  end

  private

  attr_reader :webhook, :message, :event

  def post_request
    HTTParty.post(webhook.url_path, body: body, headers: headers)
  end

  def body
    {
      topic: event.topic,
      payload: event.payload
    }.to_json
  end

  def headers
    {
      'Content-Type' => 'application/json'
    }
  end
end
