class NotesController < ApplicationController
  respond_to :html, :js

  def new
    @note = Note.new
  end

  def create
    text = params["note_text"]
    puts text
    @note = Note.new(notes_params)

    #get current group
    #post that note inide that note

    #user = User.find_by_remember_token(cookies[:remember_token])
    #user.notes << @note
    @note.errors.messages
      if @note.save
       
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