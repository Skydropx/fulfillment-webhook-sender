# == Schema Information
#
# Table name: events
#
#  id               :bigint           not null, primary key
#  external_user_id :string
#  payload          :json
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  topic            :integer
#
require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'associations' do
    it 'has many messages' do
      expect(Event.reflect_on_association(:messages).macro).to eq(:has_many)
    end

    it 'has_many webhooks' do
      expect(Event.reflect_on_association(:webhooks).macro).to eq(:has_many)
    end
  end

  describe 'enum topic' do
    context 'with a valid topic' do
      it 'is valid' do
        event = Event.new(topic: :order_created)
        expect(event).to be_valid
      end
    end

    context 'with an invalid topic' do
      it 'is invalid' do
        expect { Event.new(topic: :invalid) }.to raise_error(ArgumentError)
      end
    end
  end
  
  describe 'callbacks' do
    describe 'after_create' do
      it 'calls #create_message' do
        webhook = Webhook.create(topic: :order_created, external_user_id: '123')
        event = Event.new(topic: :order_created, external_user_id: '123')
        expect { event.save }.to change { Message.count }.by(1)
      end
    end
  end
end
