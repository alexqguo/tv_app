class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def show
		@user = User.find_by_id(params[:id])

		if !!current_user && current_user != @user
			@following = current_user.is_following?(@user)
		end

		unless @user
			render json: "user not found"
		end
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)

		if @user.save
			sign_in @user
			redirect_to @user
		else
			flash.now[:errors] = @user.errors.full_messages
			render :new
		end
	end

	def edit
		render json: "not implemented"
	end

	def update
		fail
	end

	def toggle_follow
		if request.xhr?
			@user = User.find(params[:user_id])

			if @user && !!current_user
				if current_user.is_following?(@user)
					current_user.follow_for_user(@user).destroy
					render json: {"nowFollowing" => false}
				else
					current_user.follows.create(followed_id: @user.id)
					render json: {"nowFollowing" => true}
				end
			else
				render json: {}, status: 400
			end
		else
			redirect_to root_url
		end
	end

	def viewed_ep_ids
		if request.xhr?
			@user, @show_id = User.find(params[:user_id]), params[:show_id]

			if @user && @show_id
				render json: @user.viewed_episode_ids_for_show(@show_id)
			else
				render json: {error: "One or more of the requested resources was not found"}, status: 400
			end
		else
			redirect_to root_url
		end
	end

	private
	def user_params
		params.require(:user).permit(:username, :password)
	end

end
