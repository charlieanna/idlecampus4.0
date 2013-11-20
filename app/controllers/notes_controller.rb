class NotesController < ApplicationController
  respond_to :html, :js

  def new
    @note = Note.new
  end

  def create
    puts params["group"]
    group = Group.find_by(group_code:params["group"])
    text = params["note_text"]
    puts text
    @note = group.notes.create(notes_params)

   
    @note.errors.messages
      if @note.save
        xmpp = DRbObject.new_with_uri "druby://localhost:7777"
        xmpp.publish(text,params["group"])
       
        render :json => @note
      else
        puts @note.errors.full_messages
      end

  end

  private

  def notes_params
    params.require(:note).permit(:file)
  end


end