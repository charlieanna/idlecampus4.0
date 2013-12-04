class PushesController < ApplicationController
  protect_from_forgery except: :create
  def create
    from = params["from"]
    members = members_in_array(params)
    args = { from: from.split("@").first,members: members, message: params['message'], app: 'message' }
    PygmentsWorker.perform_async(args)
    render text: 'OK'
  end
  
  
  
  def members_in_array(params)
    [params["to"]]
  end
end

