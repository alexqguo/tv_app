# == Schema Information
#
# Table name: episodes
#
#  id            :integer          not null, primary key
#  name          :string(255)      not null
#  season_id     :integer          not null
#  season_number :integer          not null
#  tmdb_id       :integer          not null
#  show_id       :integer          not null
#  show_tmdb_id  :integer          not null
#  still_path    :string(255)
#  description   :text
#  air_date      :date
#  created_at    :datetime
#  updated_at    :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :episode do
  end
end