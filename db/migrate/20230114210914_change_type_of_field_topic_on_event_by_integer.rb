# frozen_string_literal: true

class ChangeTypeOfFieldTopicOnEventByInteger < ActiveRecord::Migration[7.0]
  def change
    remove_column :events, :topic
    add_column :events, :topic, :integer
  end
end
