# == Schema Information
#
# Table name: shows
#
#  id                :integer          not null, primary key
#  name              :string(255)      not null
#  description       :text
#  in_production     :boolean          not null
#  release_date      :date
#  poster_image_path :string(255)
#  created_by        :string(255)
#  tmdb_id           :integer          not null
#  created_at        :datetime
#  updated_at        :datetime
#

class Show < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: [:slugged, :finders]

	validates :name, :tmdb_id, presence: true, uniqueness: true

	before_validation :complete_data

	has_many :user_shows
	has_many :users, through: :user_shows
	has_many :seasons, dependent: :destroy

	def all_episodes
		# avoid unnecessary query with this, don't just do
		# self.seasons.each do |x|
		# 	get episodes
		# end
		# 
		# can probably do this more efficiently with sql
		nil
	end

	def sorted_seasons
		self.seasons.order(:season_number)
	end

	def full_image_url
		"https://image.tmdb.org/t/p/w185" + self.poster_image_path
	end

	def season_number(num)
		self.seasons.where(season_number: num).first
	end

	# Don't really need this or the one above but it makes the
	# method below prettier and they're nice-to-haves
	def episodes_for_season(num)
		season_number(num).episodes
	end

	def view_all_episodes_for_season(user, num)
		resp = {season: num}
		eps = episodes_for_season(num)

		eps.each do |episode|
			view = EpisodeView.find_by_user_and_episode(user.id, episode.id)

			if view
				view.add_view!
			else
				view = user.episode_views.create(episode_id: episode.id)
			end
			view.episode.create_activity :create, owner: user
			resp["episode-#{episode.id}_viewcount"] = view.view_count

		end

		resp
	end

	def need_to_fetch?
		self.seasons.count == 0
	end

	def api_detail_call
		Tmdb::TV.detail(self.tmdb_id)
	end

	def get_seasons # make this private later?
		season_idx = 1

		loop do
			season = Tmdb::Season.detail(self.tmdb_id, season_idx)
			break unless season.season_number

			self.seasons.create({
				season_number: season.season_number,
				tmdb_id: season.id,
				show_tmdb_id: self.tmdb_id,
				description: season.overview,
				poster_path: season.poster_path
			})

			season_idx += 1
		end
	end

	private

	def complete_data
		details = api_detail_call

		self.name = details.original_name
		self.in_production = details.in_production
		self.description = details.overview
		self.release_date = details.first_air_date
		self.poster_image_path = details.poster_path
		self.created_by = details.created_by.map { |x| x.name }.join(", ")
		self.slug = self.name.downcase.gsub(" ", "-")
		# ^^hacky but whatever, coulnd't get id to generate on save
	end

end
