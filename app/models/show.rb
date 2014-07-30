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

	validates :name, :tmdb_id, :in_production, presence: true
	validates :name, :tmdb_id, uniqueness: true

	before_validation :complete_data

	has_many :user_shows
	has_many :users, through: :user_shows
	# has_many :seasons

	def all_episodes
		# avoid n+1 query with this, don't just do
		# self
		nil
	end

	def full_image_url
		"https://image.tmdb.org/t/p/w185" + self.poster_image_path
	end

	def api_detail_call
		Tmdb::TV.detail(self.tmdb_id)
	end

	private

	# allows to create show model from only tmdb_id if necessary
	# when we actually create show models in the controller we won't need to do this
	def complete_data
		details = api_detail_call

		self.name = details.original_name
		self.in_production = details.in_production
		self.description = details.overview
		self.release_date = details.first_air_date
		self.poster_image_path = details.poster_path
		self.created_by = details.created_by.map { |x| x.name }.join(", ")
		# do seasons and episodes?
	end
end
