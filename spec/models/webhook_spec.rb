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
  #pending "add some examples to (or delete) #{__FILE__}"
end
