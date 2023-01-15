# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :external_user_id
      t.json :payload
      t.string :topic

      t.timestamps
    end
  end
end
