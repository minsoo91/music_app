class TracksController < ApplicationController
	before_action :logged_in
	
	def show
		@track = Track.find(params[:id])
		render :show
	end

	def new
		@track = Track.new
		render :new
	end

	def edit
		@track = Track.find(params[:id])

		render :edit
	end

	def create
		@track = Track.new(track_params)
		if @track.save
			redirect_to track_url(@track)
		else
			flash[:errors] = @track.errors.full_messages
			render :new
		end
	end

	def update
		@track = Track.find(params[:id])
		if @track.update(track_params)
			redirect_to track_url(@track)
		else
			render :edit
		end
	end

	def destroy
		@track = Track.find(params[:id])
		@track.destroy!

		redirect_to album_url(Album.find(@track.album_id))
	end

	private
		def track_params
			params.require(:track).permit(:name, :album_id, :edition, :lyrics)
		end
end
