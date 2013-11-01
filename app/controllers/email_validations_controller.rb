class EmailValidationsController < ApplicationController
  def show
    
    email = params[:email]
    valid = Email.new(email).validate 
    if valid
      respond_with :success
    else
      respond_with :bad_request
    end
  end
end