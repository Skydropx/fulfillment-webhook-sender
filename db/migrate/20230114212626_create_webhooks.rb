class CreateWebhooks < ActiveRecord::Migration[7.0]
  def change
    create_table :webhooks do |t|
      t.string :url_path
      t.string :external_used_id
      t.integer :topic

      t.timestamps
    end
  end
end
