#
class NotesController < ApplicationController
  respond_to :html, :js

  def new
    @note = Note.new
  end

  def show
    note = Note.find(params[:id])
    notes = {}
    notes['link'] = note.file.url
    notes['message'] = note.message
    notes['name'] = note.file.path.split('/').last
    @note = ActiveSupport::JSON.encode(notes)
    render json: @note
  end

  def create
    group = Group.find_by(group_code: params['group'])
    @note = group.notes.build(notes_params)
    if params[:note][:file]
      @note.file = params[:note][:file]
    end
    @note.note = params["note_text"]
    @note.members = params[:members].split(',')
    @note.message = params["note_text"]
    @note.errors.messages
      if @note.save
      
        
      else
        puts @note.errors.full_messages
      end
  end

  def index
    
    group = Group.find_by(group_code: params['group_id'])
    @notes = group.notes
    files = []
    @notes.each do |note|
      file = {}
      file['id'] = note.id
      unless note.file.path.nil? 
        file['name'] = note.file.path.split('/').last 
      end
      file['url'] = note.file.url
      file['message'] = note.message
      files << file
    end
    notes = {}
    notes['files'] = files
    @note = ActiveSupport::JSON.encode(notes)
    render json: @note
  end

  private

  def notes_params
    params.require(:note).permit(:message)
  end
end
