module SessionsHelper

	def sign_in(user)
		new_session = user.sessions.create!
		session[:token] = new_session.session_token
	end

	def sign_out(user)
		Session.find_by_session_token(session[:token]).destroy
		session[:token] = nil
	end

	def current_user
		return nil unless session[:token]
		@current_user ||= Session.find_by_session_token(session[:token])
	end

	def require_current_user!
		unless current_user
      flash[:errors] = "You must be logged in to do that!"
      redirect_to new_session_url
    end
	end

	def require_no_user!
		redirect_to root_url if !!current_user
	end

end
