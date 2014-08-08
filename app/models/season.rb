# == Schema Information
#
# Table name: seasons
#
#  id            :integer          not null, primary key
#  season_number :integer          not null
#  show_id       :integer          not null
#  tmdb_id       :integer          not null
#  show_tmdb_id  :integer          not null
#  poster_path   :string(255)
#  description   :text
#  created_at    :datetime
#  updated_at    :datetime
#

class Season < ActiveRecord::Base
	validates :season_number, :show_id, :tmdb_id, presence: true

	before_save :get_episodes

	belongs_to :show
	has_many :episodes

	def full_image_url
		"https://image.tmdb.org/t/p/w185" + self.poster_path
	end

	def api_detail_call
		Tmdb::Season.detail(self.tmdb_id)
	end

	def get_episodes # make this private later?
		episode_idx = 1

		loop do
			episode = Tmdb::Episode(self.show_tmdb_id, self.season_number, episode_idx)
			break unless episode.episode_number
			# create and save episode
			self.episodes.create({
				name: episode.name,
				season_id: self.id,
				season_number: self.season_number,
				tmdb_id: episode.id,
				show_id: self.show_id,
				show_tmdb_id: self.show_tmdb_id,
				still_path: episode.still_path,
				description: episode.overview,
				air_date: episode.air_date
			})

			episode_idx += 1
		end
	end

end
