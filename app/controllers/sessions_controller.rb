require 'ruby_bosh'
class SessionsController < ApplicationController
  respond_to :html, :js
	def new
	end

  def index 
  end

	def create

      user = User.find_by_email(params[:session][:email])
      if user
        @email = user.jabber_id
        @password = params[:session][:password]
        p "QWEQWEWQEWQEQW"
        begin
          @session_jid, @session_id, @session_random_id =
              RubyBOSH.initialize_session(@email, @password, "http://idlecampus.com/http-bind")

          p "UUUUUUUUUU"
          p @session_id
          p @session_jid
          p @session_random_id
          sign_in user,@session_jid, @session_id, @session_random_id

          p cookies

          @cookies = cookies
          # redirect_to user
          # else
          #    flash[:error] = 'Invalid email/password combination' # Not quite right!
          #     render 'new'
          # end

          #@assignment = Assignment.new
          # @assignment.save

          #@note = Note.new

          # @note.save
          # user.notes << @note
          # user.assignments << @assignment
          # user.save
          #   <li><%= link_to "<div class='box'><span><i class='icon-briefcase icon-white'></i></span>Developer</div>".html_safe, :controller => :developers, :action => :show %></li>
          attacher = {}
          attacher[:JID] = @session_jid
          attacher[:SID] = @session_id
          attacher[:RID] = @session_random_id
          gon.attacher = attacher
          render 'initbosh'
        rescue

          redirect_to :back,:flash => { :error =>  'Invalid email/password combination' }
        end

        #if user && user.authenticate(params[:session][:password])

      else


        redirect_to :back,:flash => { :error =>  'Invalid email/password combination' }
      end








  end


  

   def destroy
    sign_out
    redirect_to root_url
  end
end
