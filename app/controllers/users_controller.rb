class UsersController < ApplicationController
	 
	 before_filter :admin_user, :except => [:new]

	 def index
	 	@users = User.all
	 end

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		@user.update_attributes(params[:user])
		redirect_to root_path
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to TeleCoach"
			redirect_to @user
		else
			render 'new'
		end
	end

	def destroy
		@user = User.find(params[:user])
		@user.destroy
		redirect_to users_path
	end
	private

		def signed_in_user
		  unless signed_in?
		    store_location
		    redirect_to signin_path, notice: "Please sign in."
		  end
		end

		def correct_user
		  @user = User.find(params[:id])
		  redirect_to(root_path) unless current_user?(@user)
		end

		def admin_user
	      redirect_to(root_path) unless current_user.admin?
	    end
end
