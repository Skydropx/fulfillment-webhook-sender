# frozen_string_literal: true

class KafkaConfig
  # 1. Set the group id to the name of your app
  GROUP_ID = 'webhook-sender'
  TOPICS = %w[order_created].freeze

  def self.topics
    TOPICS
  end

  def self.prefix
    ENV.fetch('KAFKA_PREFIX', '').to_s
  end

  def self.with_prefix(name)
    "#{ENV.fetch('KAFKA_PREFIX', '')}#{name}"
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
    return {} unless kafka_variables_present?

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
      seed_brokers: ENV.fetch('KAFKA_URL', ''),
      # ssl_ca_cert: File.read('cert.pem'),
      ssl_ca_cert: ENV.fetch('KAFKA_TRUSTED_CERT', ''),
      ssl_client_cert: ENV.fetch('KAFKA_CLIENT_CERT', ''),
      ssl_client_cert_key: ENV.fetch('KAFKA_CLIENT_CERT_KEY', ''),
      ssl_verify_hostname: false
    )
    $consumer = consumer_kafka.consumer(group_id: with_prefix(GROUP_ID))
    $recent_messages = []
  rescue OpenSSL::X509::CertificateError => e
    {}
  end

  def self.test_consumer(topic)
    KafkaConfig.basic_consumer_local_config
    Thread.new do
      $consumer.subscribe(KafkaConfig.with_prefix(topic))

      # Consume messages from the topics
      begin
        $consumer.each_message do |message|
          # Remember the last 10 events
          $recent_messages << [message, { received_at: Time.now.iso8601 }]
          $recent_messages.shift if $recent_messages.length > 10

          puts "Topic: #{message.topic}, Partition: #{message.partition}, Offset: #{message.offset}, Key: #{message.key}, Value: #{message.value}"
        end
      rescue Exception => e
        puts 'CONSUMER ERROR'
        puts "#{e}\n#{e.backtrace.join("\n")}"
        # exit(1)
      end
    end
  end

  def self.kafka_variables_present?
    ENV['KAFKA_URL'].present? &&
      ENV['KAFKA_CLIENT_CERT'].present? &&
      ENV['KAFKA_CLIENT_CERT_KEY'].present? &&
      ENV['KAFKA_TRUSTED_CERT'].present?
  end
end
