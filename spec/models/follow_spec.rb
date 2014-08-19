# == Schema Information
#
# Table name: follows
#
#  id          :integer          not null, primary key
#  follower_id :integer          not null
#  followed_id :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

RSpec.describe Follow, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
