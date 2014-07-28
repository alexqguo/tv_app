class UsersController < ApplicationController

	def index
		render json: User.all
	end

	def show
		@user = User.find_by_id(params[:id])

		if @user
			render json: @user
		else
			render json: "user not found"
		end
	end

	def new
		render json: "not implemented"
	end

	def create
		render json: "not implemented"
	end

	def edit
		render json: "not implemented"
	end

	def upeate
		render json: "not implemented"
	end

	private
	def user_params
		params.require(:user).permit(:username, :password)
	end

end
