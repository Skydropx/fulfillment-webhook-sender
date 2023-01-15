# frozen_string_literal: true

# == Schema Information
#
# Table name: webhooks
#
#  id               :bigint           not null, primary key
#  url_path         :string
#  external_used_id :string
#  topic            :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

# Each webhook is associated with a user, and a user can have many webhooks
# for a given event.
class Webhook < ApplicationRecord
  # Enum for mapping each topic on KafkaConfig.topics with an integer.
  enum topic: KafkaConfig.topics.each_with_index.map { |topic, index| [topic, index] }.to_h

  has_many :messages
end
