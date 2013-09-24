class StaticPagesController < ApplicationController
  def home
    gon.names = "ankur kothari"
  end

  def help
  end

  def tour
  end

  def contact
  end

  def about
  end
end
