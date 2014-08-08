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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :season do
  end
end
