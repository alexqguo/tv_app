# == Schema Information
#
# Table name: seasons
#
#  id            :integer          not null, primary key
#  season_number :integer          not null
#  show_id       :integer          not null
#  tmdb_id       :integer          not null
#  poster_path   :string(255)
#  description   :text
#  created_at    :datetime
#  updated_at    :datetime
#

class Season < ActiveRecord::Base
	validates :season_number, :show_id, :tmdb_id, presence: true

	before_validation :complete_data

	belongs_to :show
	# has_many :episodes

	def full_image_url
		"https://image.tmdb.org/t/p/w185" + self.poster_path
	end

	private

	def complete_data
		
	end

	def get_episodes
		
	end

end
