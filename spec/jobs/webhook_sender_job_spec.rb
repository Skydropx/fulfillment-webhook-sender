# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WebhookSenderJob, type: :job do
  describe '#perform' do
    let!(:seeds) { Rails.application.load_seed }

    it 'enqueues a job' do
      expect { WebhookSenderJob.perform_later }.to have_enqueued_job
    end
  end
end
