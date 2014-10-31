class SessionsController < ApplicationController
	def new
		@user = User.new
		render :new
	end

	def create
		@user = User.find_by_credentials(
			params[:user][:email], 
			params[:user][:password])
		if @user.nil?
			render :new
		else
			@user.reset_session_token!
			login!(@user)
			redirect_to bands_url
		end
	end

	def destroy
		user = current_user
	    session[:session_token] = nil
	    user.reset_session_token!
	    current_user = nil
	    redirect_to user_url
	end
end
