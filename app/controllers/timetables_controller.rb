class TimetablesController < ApplicationController
  respond_to :json

  def new
    @group = Group.find(params[:group_id])
    @timetable = @group.build_timetable
  end


  def create
    

   
        timetable = Timetable.create_timetable(params)
     


      if timetable.save

        render status: 200, nothing: true

      end

 
   
  end

  



  def show
    
    group = params["group_id"]
    
    group = Group.find_by_group_code(group)
    
    timetable = group.timetable


    timetable_in_hash = timetable.timetable_in_hash
    
    
   
    
    render :json => timetable_in_hash
  end

  private


  def timetable_params
    params.require(:timetable)
  end
end
