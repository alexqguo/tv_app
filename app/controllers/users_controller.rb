class UsersController < ApplicationController

	def index
		@users = User.all
		fail
	end

	def show
		@user = User.find_by_id(params[:id])

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

	private
	def user_params
		params.require(:user).permit(:username, :password)
	end

end
