module SessionsHelper
	def sign_in(user)
		remember_token = User.create_remember_token
		cookies.permanent[:remember_token] = remember_token
		user.update_attributes(remember_token: User.digest(remember_token))
		self.current_user = user
	end
end
