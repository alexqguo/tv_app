# == Schema Information
#
# Table name: episodes
#
#  id             :integer          not null, primary key
#  name           :string(255)      not null
#  season_id      :integer          not null
#  season_number  :integer          not null
#  tmdb_id        :integer          not null
#  show_id        :integer          not null
#  show_tmdb_id   :integer          not null
#  still_path     :string(255)
#  description    :text
#  air_date       :date
#  created_at     :datetime
#  updated_at     :datetime
#  episode_number :integer          not null
#

class Episode < ActiveRecord::Base
	include PublicActivity::Common
	
	validates :name, :season_id, :season_number, :tmdb_id, :show_id, 
						:show_tmdb_id, :episode_number, presence: true

	belongs_to :season
	has_many :episode_views

	def still_image_url
		"https://image.tmdb.org/t/p/w185" + self.still_path # TODO: change the prefix
	end

	def show
		Show.find(self.show_id)
	end

	def episode_string
		str = "S#{self.season_number}E#{self.episode_number}"
	end

end
