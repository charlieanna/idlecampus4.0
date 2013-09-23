class TimetablesController < ApplicationController

	def new
		@group = Group.find(params[:group_id])
		@timetable = @group.build_timetable
	end

	def create
		@group = Group.find(params[:group_id])
      @timetable = @group.build_timetable(params[:timetable])
      if @timetable.save
        flash[:notice] = "Timetable has been created."
        redirect_to [@group, @timetable]
      else
        flash[:alert] = "Timetable has not been created."
        render "new"
      end
    end

   private
     def timetable_params
        params.require(:timetable)
     end
end
