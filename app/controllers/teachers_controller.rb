class TeachersController < ApplicationController
  def new
    @user = Teacher.new
  end
end
