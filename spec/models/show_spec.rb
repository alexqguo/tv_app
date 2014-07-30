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

require 'rails_helper'

RSpec.describe Show, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
