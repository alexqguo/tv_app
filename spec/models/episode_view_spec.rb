# == Schema Information
#
# Table name: episode_views
#
#  id         :integer          not null, primary key
#  episode_id :integer          not null
#  user_id    :integer          not null
#  view_count :integer          default(0), not null
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe EpisodeView, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
