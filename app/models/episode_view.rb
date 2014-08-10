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

class EpisodeView < ActiveRecord::Base
	validates :episode_id, :user_id, :view_count, presence: true
	validates_numericality_of :view_count, greater_than_or_equal_to: 0

	belongs_to :episode
	belongs_to :user

	def add_view!
		self.view_count += 1
		self.save!
	end
end
