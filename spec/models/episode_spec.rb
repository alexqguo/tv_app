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

require 'rails_helper'

RSpec.describe Episode, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
