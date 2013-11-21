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
    @note = group.note.build(notes_params)
    @note.errors.messages
      if @note.save
        xmpp = DRbObject.new_with_uri 'druby://localhost:7777'
        xmpp.publish(@note.message, params['group'])
        render json: @note
      else
        puts @note.errors.full_messages
      end
  end

  def index
    group = Group.find_by(group_code: params['group'])
    @notes = group.notes
    files = []
    @notes.each do |note|
      file = {}
      file['id'] = note.id
      file['name'] = note.file.path.split('/').last
      file['url'] = note.file.url
      files << file
    end
    notes = {}
    notes['files'] = files
    @note = ActiveSupport::JSON.encode(notes)
    render json: @note
  end

  private

  def notes_params
    params.require(:note).permit(:file, :message)
  end
end
