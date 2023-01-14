# frozen_string_literal: true

class OrderCreatedConsumer 
  def consume(message)
    puts "Received message: #{message.key}, #{message.value}"
  end
end

