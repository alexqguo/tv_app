# == Schema Information
#
# Table name: sessions
#
#  id            :integer          not null, primary key
#  session_token :string(255)      not null
#  user_id       :integer          not null
#  created_at    :datetime
#  updated_at    :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :session do
  end
end
