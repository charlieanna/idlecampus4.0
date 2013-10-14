class CheckNamesController < ApplicationController
  respond_to :json
  def show
     if User.exists?(:jabber_id => "#{params[:name]}@idlecampus.com")
       respond_with params[:name],:status =>:not_found
     else
       respond_with(params[:name], :status => :found)
     end
  end