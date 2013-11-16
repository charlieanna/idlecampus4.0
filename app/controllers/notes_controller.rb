class NotesController < ApplicationController
  respond_to :html, :js

  def new
    @note = Note.new
  end

  def create

    @note = Note.new(notes_params)

    #get current group
    #post that note inide that note

    #user = User.find_by_remember_token(cookies[:remember_token])
    #user.notes << @note
   
      if @note.save
        p [@note.to_jq_upload].to_json
        render text: "ok"
      else
        puts @note.errors.full_messages
      end

  end

  private

  def notes_params
    params.require(:note).permit(:file)
  end


end