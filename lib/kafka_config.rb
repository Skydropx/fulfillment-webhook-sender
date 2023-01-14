# frozen_string_literal: true

class KafkaConfig

  # 1. Set the group id to the name of your app
  GROUP_ID = 'webhook-sender'.freeze

  def self.prefix
    "#{ENV['KAFKA_PREFIX']}"
  end

  def self.with_prefix(name)
    "#{ENV['KAFKA_PREFIX']}#{name}"
  end

  def self.consumer_mapper
    with_prefix(GROUP_ID)
  end

  def self.karafka_local_config
    {
      'bootstrap.servers': '127.0.0.1:9092'
    }
  end

  def self.karafka_production_config
    {
    'security.protocol': 'ssl',
    'bootstrap.servers': ENV['KAFKA_URL'].gsub('kafka+ssl://', ''),
    'ssl.certificate.pem': ENV['KAFKA_CLIENT_CERT'],
    'ssl.key.pem': ENV['KAFKA_CLIENT_CERT_KEY'],
    'ssl.ca.pem': ENV['KAFKA_TRUSTED_CERT'],
    'group.id': "#{ENV['KAFKA_PREFIX']}#{GROUP_ID}"
    }
  end

  def self.basic_consumer_local_config
    consumer_kafka = Kafka.new(
      seed_brokers: ['127.0.0.1:9092']
    )
    $consumer = consumer_kafka.consumer(group_id: with_prefix(GROUP_ID))
    $recent_messages = []
  end

  def self.basic_consumer_production_config
    consumer_kafka = Kafka.new(
      seed_brokers: ENV.fetch('KAFKA_URL'),
      ssl_ca_cert: File.read('cert.pem'),
      # ENV.fetch('KAFKA_TRUSTED_CERT'),
      ssl_client_cert: ENV.fetch('KAFKA_CLIENT_CERT'),
      ssl_client_cert_key: ENV.fetch('KAFKA_CLIENT_CERT_KEY'),
      ssl_verify_hostname: false,
    )
    $consumer = consumer_kafka.consumer(group_id: with_prefix(GROUP_ID))
    $recent_messages = []
  end
end
