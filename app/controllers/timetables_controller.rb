class TimetablesController < ApplicationController
  respond_to :json

  def new
    @group = Group.find(params[:group_id])
    @timetable = @group.build_timetable
  end


  def create
    group = Group.find_by_group_code(params['timetable']["group"]["group_code"])
    
    timetable = Timetable.find_or_create_by(group_id: group.id)

    if group

      timetable.create_timetable(params)


      if timetable.save

        render status: 200, nothing: true

      end

    end

   
  end

  def build_f(fields)
    f = []
    fields.each do |field|

      f.push(Class.new(ActiveRecord::Base) do
        self.table_name = field.name
        #belongs_to :timetable_entry
      end)


    end
    return f
  end

  



  def show
    
    group = params["group_id"]
    
    group = Group.find_by_group_code(group)

    timetable_in_hash = group.build_timetable_hash
    
   
    
    render :json => timetable_in_hash
  end

  private
  def timetable_params
    params.require(:timetable)
  end
end
