class AlbumsController < ApplicationController
	before_action :logged_in
	
	def show
		@album = Album.find(params[:id])
	end

	def new
		@album = Album.new
		render :new
	end

	def edit
		@album = Album.find(params[:id])
		
		render :edit
	end

	def create
		@album = Album.new(album_params)
		if @album.save
			redirect_to album_url(@album)
		else
			flash[:errors] = @album.errors.full_messages
			render :new
		end
	end

	def update
		@album = Album.find(params[:id])
		if @album.update(album_params)
			redirect_to album_url(@album)
		else
			flash[:errors] = @album.errors.full_messages
			render :edit
		end
	end

	def destroy
		@album = Album.find(params[:id])
		@album.destroy!

		redirect_to band_url(Band.find(@album.band_id))
	end

	private
		def album_params
			params.require(:album).permit(:name, :band_id, :edition)
		end
end
