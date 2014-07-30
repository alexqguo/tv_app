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

class UserShow < ActiveRecord::Base

	validates :user_id, :show_id, presence: true
	validates_uniqueness_of :user_id, scope: :show_id

	belongs_to :show
	belongs_to :user

end
