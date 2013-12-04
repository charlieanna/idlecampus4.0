class PushesController < ApplicationController
  protect_from_forgery except: :create
  def create
    members = [params['to']]
    args = { members: members, message: params['message'], app: 'message' }
    PygmentsWorker.perform_async(args)
    render text: 'OK'
  end
end

