class NotesController < ApplicationController
  respond_to :html, :js

  def new
    @note = Note.new
  end
  
  def show
    note = Note.find(params[:id])
    file = note.file_url
    notes = {}
    notes["link"] = note.file.url
    # notes["message"] = note.
    @timetable = ActiveSupport::JSON.encode(notes)
    render :json =>  @timetable 
  end

  def create
   
    group = Group.find_by(group_code:params["group"])
    
    @note = Note.new(notes_params)

   
    @note.errors.messages
      if @note.save
        xmpp = DRbObject.new_with_uri "druby://localhost:7777"
        xmpp.publish(text,params["group"])
       
        render :json => @note
      else
        puts @note.errors.full_messages
      end

  end
  
  def index
    group = Group.find_by(group_code:params["group"])
    @notes = Note.all
    files = []
    @notes.each do |note| 
      files << note.file.path.split('/').last
    end
    notes = {}
    notes["files"] = files
    @timetable = ActiveSupport::JSON.encode(notes)
    render :json =>  @timetable 
  end

  private

  def notes_params
    params.require(:note).permit(:file,:message)
  end


end