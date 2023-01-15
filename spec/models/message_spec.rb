# == Schema Information
#
# Table name: messages
#
#  id              :bigint           not null, primary key
#  event_id        :bigint           not null
#  webhook_id      :bigint           not null
#  attempts        :integer
#  delivery_status :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe Message, type: :model do
  Rails.application.config.active_job.queue_adapter = :test
  ActiveJob::Base.queue_adapter = :test

  describe 'associations' do
    it 'belongs_to event' do
      expect(Message.reflect_on_association(:event).macro).to eq(:belongs_to)
    end

    it 'belongs_to webhook' do
      expect(Message.reflect_on_association(:webhook).macro).to eq(:belongs_to)
    end
  end

  describe 'enum delivery_status' do
    let(:webhook) { Webhook.create(topic: :order_created, external_user_id: '123') }
    let(:event) { Event.create(topic: :order_created, external_user_id: '123') }
    context 'with a valid delivery_status' do
      it 'is valid' do
        expect(described_class.new(delivery_status: :pending, event_id: event.id, webhook_id: webhook.id)).to be_valid
      end
    end

    context 'with an invalid delivery_status' do
      it 'is invalid' do
        expect { Message.new(delivery_status: :invalid) }.to raise_error(ArgumentError)
      end
    end
  end

  describe 'callbacks' do
    describe 'after_create' do
    let(:webhook) { Webhook.create(topic: :order_created, external_user_id: '123') }
    let(:event) { Event.create(topic: :order_created, external_user_id: '123') }
      it 'enqueues WebhookSenderJob' do
        expect { Message.create(event_id: event.id, webhook_id: webhook.id) }.to have_enqueued_job(WebhookSenderJob)
      end
    end
  end
end
