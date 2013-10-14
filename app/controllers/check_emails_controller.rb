class CheckEmailsController < ApplicationController
  respond_to :json
  def show
     if User.exists?(:email => params[:email])
       respond_with email,:status =>:not_found
     else
       respond_with(email, :status => :found)
     end
  end