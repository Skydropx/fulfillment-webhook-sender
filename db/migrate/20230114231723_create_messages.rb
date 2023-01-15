# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :event, null: false, foreign_key: true
      t.references :webhook, null: false, foreign_key: true
      t.integer :attempts
      t.integer :delivery_status

      t.timestamps
    end
  end
end
