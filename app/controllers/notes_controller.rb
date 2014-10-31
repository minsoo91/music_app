class NotesController < ApplicationController
	def create
		@note = Note.new(note_params)
		@note.user_id = current_user.id
		if @note.save
			redirect_to track_url(@note.track_id)
		else
			flash[:errors] = @note.errors.full_messages
			redirect_to(:back)
		end
	end

	def destroy
		@note = Note.find(params[:id])
		if current_user.id == @note.user_id
			@note.destroy!
			redirect_to track_url(@note.track_id)
		else
			raise ActionController::RoutingError.new('Forbidden')
		end
	end

	private
		def note_params
			params.require(:note).permit(:user_id, :track_id, :note_text)
		end
end
