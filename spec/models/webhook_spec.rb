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
require 'rails_helper'

RSpec.describe Webhook, type: :model do
  describe 'validations' do
    it 'has many messages' do
      expect(described_class.reflect_on_association(:messages).macro).to eq(:has_many)
    end
  end

  describe 'enum topic' do
    context 'when topic is not valid' do
      it 'is not valid' do
        expect{described_class.new(topic: 'invalid')}.to raise_error(ArgumentError)
      end
    end
  end
end
