class PartsController < ApplicationController

	def index
		@part = Part.all
	end

	def show
		@part = Part.find(params[:id])
	end

	def new
		@part = Part.new
	end

	def edit
		@part = Part.find(params[:id])
	end

	def update	
		@part = Part.find(params[:id])
		@old_size = @part.part_size
		if @part.update_attributes(params[:part])
			flash[:success] = "Part updated successfully"
			@new_size = @part.part_size
			if @old_size > @new_size
				@drop = Rand.where("part_id = ?", @part.id).limit(@old_size-@new_size)
				@drop.each do |rand|
					rand.destroy
				end
			else
				@new = @new_size-@old_size
				(1..@new).each do |part|
					Rand.create!(part_id: @part.id)
				end
			end
			redirect_to project_path(@part.project_id)
		else
			flash[:failure] = "Part not updated"
			redirect_to project_path(@part.project_id)
		end
	end

	def create
		@part = Part.new(params[:part])
		if @part.save
			flash[:success] = "New part"
			(1..@part.part_size).each do |i|
				Rand.create!(part_id: @part.id, used: false)
			end
			redirect_to project_path(@part.project_id)
		else
			render 'new'
		end
	end

	def destroy
		@part = Part.find(params[:id])
		@goto = @part.project_id
		@part.destroy
		redirect_to project_path(@goto)
	end

end
