class ProjectsController < ApplicationController

	def index
		@projects = Project.all
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
		if params[:key] == "foobar"
			if params[:id].to_i == 0
				@project = Project.find_by_project_name(params[:id])
			else
				@project = Project.find(params[:id])
			end
			@part = Part.where("project_id = ? AND used_rands < part_size", @project.id).to_a.shuffle[0]
			if !@part.nil?
				@rand = Rand.find_by_part_id_and_used(@part.id, false)
				@rand.used = true
				if @rand.save
					@part.used_rands += 1
					@part.save
				end
			else
				flash[:failure] = "No more slots to fill"
				redirect_to project_path(@project)
			end
		else
			redirect_to root_path
		end
	end

end
