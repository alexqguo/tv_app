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

require 'rails_helper'

RSpec.describe Season, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
