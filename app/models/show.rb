# == Schema Information
#
# Table name: shows
#
#  id                :integer          not null, primary key
#  name              :string(255)      not null
#  description       :text
#  in_production     :boolean          not null
#  release_date      :string(255)
#  poster_image_path :string(255)
#  created_by        :string(255)
#  tmdb_id           :integer          not null
#  created_at        :datetime
#  updated_at        :datetime
#

class Show < ActiveRecord::Base

	validates :name, :tmdb_id, :in_production, presence: true
	validates :name, :tmdb_id, uniqueness: true

	def all_episodes
		# avoid n+1 query with this
	end

	def full_image_url
		"https://image.tmdb.org/t/p/w185" + self.poster_image_path
	end

	def api_detail_call
		Tmdb::TV.detail(self.tmdb_id)
	end

	# this will mostly be used for testing
	# from this we need to get description, release_date, poster_image_path, and created_by
	def complete_data
		details = api_detail_call

		self.description = details.overview
		self.release_date = details.first_air_date
		self.poster_image_path = details.poster_path
		self.created_by = details.created_by.map { |x| x.name }.join(",")

		
	end
end
