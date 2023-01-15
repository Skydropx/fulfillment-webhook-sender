# frozen_string_literal: true

class FixNameOfWebhookColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :webhooks, :external_used_id, :external_user_id
  end
end
