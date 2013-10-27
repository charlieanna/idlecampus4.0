class StaticPagesController < ApplicationController
  before_filter :check_logged_in_user
  
  def home
    gon.names = "ankur kothari"
  end

  def contact
  end

  def about
  end


  private 
	
  	def check_logged_in_user

  		if signed_in?
  			redirect_to current_user
  		end
  	end
end
