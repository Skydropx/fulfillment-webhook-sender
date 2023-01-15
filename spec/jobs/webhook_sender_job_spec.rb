# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WebhookSenderJob, type: :job do
  describe '#perform' do
    let!(:seeds) { Rails.application.load_seed }

    it 'enqueues a job' do
      expect { WebhookSenderJob.perform_later }.to have_enqueued_job
    end

    context 'with a valid param (event)' do
      it 'updates the message' do
        expect(WebhookSenderJob.perform_now(Message.first.id)).to eq(true) 
      end
    end
  end
end
