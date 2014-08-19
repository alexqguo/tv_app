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

class Follow < ActiveRecord::Base
	validates :follower_id, :followed_id, presence: true
	validates_uniqueness_of :follower_id, scope: :followed_id

	belongs_to :follower, class_name: "User"
	belongs_to :followed, class_name: "User"
end
