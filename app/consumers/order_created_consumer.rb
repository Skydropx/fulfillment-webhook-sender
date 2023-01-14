# frozen_string_literal: true

class OrderCreatedConsumer < ApplicationConsumer
  def consume(message)
    #puts "Received message: #{message.key}, #{message.value}"
    process_default
  end
end

