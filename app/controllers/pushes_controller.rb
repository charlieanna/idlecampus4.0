class PushesController < ApplicationController
  protect_from_forgery except: :create
  def create
    from = params["from"]
    members = [params['to']]
    args = { from: from,members: members, message: params['message'], app: 'message' }
    PygmentsWorker.perform_async(args)
    render text: 'OK'
  end
end

