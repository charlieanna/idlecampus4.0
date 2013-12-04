class PushesController < ApplicationController
  protect_from_forgery except: :create
  def create
    from = params["from"]
    members = members_in_array(params)
    count = from.split("@").count
    if count == 2
      args = { from: from.split("@").first,members: members, message: params['message'], app: 'message' }
    else
      args = { from: Group.find_by(group_code:from).name,members: members, message: params['message'], app: 'message' }
    end
    PygmentsWorker.perform_async(args)
    render text: 'OK'
  end
  
  
  
  def members_in_array(params)
    [params["to"]]
  end
end

