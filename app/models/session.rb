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

class Session < ActiveRecord::Base

	validates :session_token, :user, presence: true
	validates_uniqueness_of :session_token, scope: :user_id

	after_initialize :ensure_session_token
	belongs_to :user

	def reset_token!
		self.session_token = self.class.generate_token
		self.save!
		self.session_token
	end

	def self.generate_token
		SecureRandom::urlsafe_base64(16)
	end

	private

	def ensure_session_token
		self.session_token ||= self.class.generate_token
	end

end
