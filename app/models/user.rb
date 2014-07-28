# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
	attr_reader :password

	validates :username, uniqueness: true
	validates :password, length: { minimum: 6, allow_nil: true }
	validates :username, :password_digest, presence: true

	before_validation :ensure_token

	def password=(pass)
		@password = pass
		self.password_digest = BCrypt::Password.create(pass)
	end

	def is_password?(pass)
		BCrypt::Password.new(self.password_digest).is_password?(pass)
	end

	def reset_token!
		self.session_token = self.class.generate_token
		self.save!
		self.session_token
	end

	def self.generate_token
		SecureRandom::urlsafe_base64(16)
	end

	def self.find_by_credentials(username, password)
		user = User.find_by_username(username)
		return nil if user.nil?
		user.is_password?(password) ? user : nil
	end

	private

	def ensure_token
		self.session_token ||= self.class.generate_token
	end

end
