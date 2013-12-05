class FilesController < ApplicationController
  def index
    @group = Group.find(params['group_id'])
    @notes = @group.notes
    files = []
    @files = @notes.pluck(:file)
    # render json: @note
  end
end
