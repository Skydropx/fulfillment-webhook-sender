# README

This microservice receives events from Kafka, map them and send them as webhooks via API REST.

## Event broker configuration

This project gives you the posibility of producing and consuming messages.

Locally, you can use Docker to mount Kafka & Zookeeper on localhost:9092.

Remotely, the project is set to support Heroku Kafka. If you have your cluster in other location, you can modify the configuration on ``lib/kafka_config.rb``.

### Quick setup

#### Consumers

1. Set GROUP_ID on ``lib/kafka_config.rb``.
2. Register TOPICS on `config/initializers/basic_consumer.rb`.
3. Create consumer classes for each topic on `app/consumers/TOPIC_consumer.rb` and include a method consume able to receive a message.

#### Producing messages

You can easily send a message as follows:

``
kafka = Kafka.new('localhost:9092')
kafka.deliver_message("Hello, world!", topic: "#{ENV['KAFKA_PREFIX']}topic_name")
``

Also, you are able to debug messages trough console using:

`KafkaConfig.test_consumer 'topic_name'`

This will subscribe your console session to a logger and the messages that you send to `topic_name` will be shown live.
