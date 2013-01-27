class ProjectsController < ApplicationController

	before_filter :signed_in_user

	def index
		if current_user.admin
			@projects = Project.all
		else
			@projects = Project.where("user_id = ?", current_user.id)
		end
	end

	def show
		if params[:id].to_i == 0
			@project = Project.find_by_project_name(params[:id])
		else
			@project = Project.find(params[:id])
		end
		@parts = Part.where("project_id = ?", @project.id)
	end

	def new
		@project = Project.new
	end

	def edit
		if params[:id].to_i == 0
			@project = Project.find_by_project_name(params[:id])
		else
			@project = Project.find(params[:id])
		end
	end

	def update
		if params[:id].to_i == 0
			@project = Project.find_by_project_name(params[:id])
		else
			@project = Project.find(params[:id])
		end
		if @project.update_attributes(params[:project])
			flash[:success] = "Project updated successfully"
			redirect_to project_path
		else
			flash[:failure] = "Project not updated"
			redirect_to project_path
		end
	end

	def create
		@project = Project.new(params[:project])
		@project.project_hash = (0...12).map{65.+(rand(25)).chr}.join
		if @project.save
			flash[:success] = "New project"
			redirect_to project_path(@project)
		else
			render 'new'
		end
	end

	def destroy
		@project = Project.find(params[:id])
		@project.destroy
		redirect_to projects_path
	end


	def claim
		@project = Project.find(params[:id])
		if params[:key] == @project.project_hash
			if params[:id].to_i == 0
				@project = Project.find_by_project_name(params[:id])
			else
				@project = Project.find(params[:id])
			end
			@part = Part.where("project_id = ? AND used_rands < part_size", @project.id).to_a.shuffle.first
			if !@part.nil?
				@rand = Rand.find_by_part_id_and_used(@part.id, false)
				@rand.used = true
				if @rand.save
					@part.used_rands += 1
					@part.save
				end

				respond_to do |format|
					format.html
					format.json { render :json => { part_name: @part.part_name , project_id: @part.project_id } , :layout => false }
				end

			else
				add_more
			end
		else
			redirect_to root_path
		end
	end

	private

		def add_more
			project = Project.find(params[:id])
			project.parts.each do |part|
				part.part_size += project.increment_size
				part.save
				(0..project.increment_size).each do |i|
					Rand.create!(part_id: part.id)
				end
			end
			redirect_to claim_project_path(key: project.project_hash)
		end

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
