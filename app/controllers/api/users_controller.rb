class UsersController < ApplicationController
	# respond_to :json
	def create
    puts params
        @user = User.new
        @user.password = params[:password]
        @user.password_confirmation = @user.password
        @user.email = params[:email]
        @user.jabber_id =  params[:jabber_id]
       
        @user.device_identifier = params[:device_identifier]
        puts @user
        puts @user.valid?
        puts @user.errors.full_messages
         @user.save
        
        respond_with(@user)
	end
end