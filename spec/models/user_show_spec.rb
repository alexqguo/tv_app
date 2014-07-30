# == Schema Information
#
# Table name: user_shows
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  show_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe UserShow, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
