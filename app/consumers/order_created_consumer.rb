# frozen_string_literal: true

class OrderCreatedConsumer < ApplicationConsumer
  def consume(message)
    process_default(message)
  end
end
