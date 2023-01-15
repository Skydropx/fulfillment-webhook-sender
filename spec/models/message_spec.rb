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
  #pending "add some examples to (or delete) #{__FILE__}"
end
