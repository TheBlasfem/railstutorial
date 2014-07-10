class User < ActiveRecord::Base
	has_many :microposts, dependent: :destroy
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	validates :name, presence: true, length: { maximum: 50 }
	validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i }
	before_save { email.downcase! }
	before_create :create_remember_token
	has_secure_password
	validates :password, length: { minimum: 6 }

	def self.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def self.digest(token)
		Digest::SHA1::hexdigest(token.to_s)
	end

	def feed
		Micropost.where("user_id = ?", id)
	end

	private
		def create_remember_token
			self.remember_token = User.digest(User.new_remember_token)
		end

end
