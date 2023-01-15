# Initialize consumers

require 'kafka_config'

if Rails.env.development?
  KafkaConfig.basic_consumer_local_config
else
  KafkaConfig.basic_consumer_production_config
end

# 2. Register to the topics you want to consume (without the prefix)
# 3. Create a consumer class for each topic
# Path: app/consumers/{{topic}}_consumer.rb

Thread.new do
  # Subscribe to the topics
  KafkaConfig.topics.each do |topic|
    $consumer.subscribe(KafkaConfig.with_prefix(topic))
  end

  # Consume messages from the topics
  begin
    $consumer.each_message do |message|
      # Remember the last 10 events
      $recent_messages << [message, { received_at: Time.now.iso8601 }]
      $recent_messages.shift if $recent_messages.length > 10

      # puts "Topic: #{message.topic}, Partition: #{message.partition}, Offset: #{message.offset}, Key: #{message.key}, Value: #{message.value}"

      # Process the message
      topic = message.topic.gsub(KafkaConfig.prefix, '')

      # Find the consumer for the topic
      consumer = topic + '_consumer'
      consumer = consumer.camelize.constantize

      # Process the message
      # Debug with puts "#{consumer}.new.consume(#{message.inspect})"
      consumer.new.consume(message)
    end
  rescue Exception => e
    puts 'CONSUMER ERROR'
    # puts "#{e}\n#{e.backtrace.join("\n")}"
    # puts e.backtrace.inspect
    # exit(1)
    retry
  end
end
