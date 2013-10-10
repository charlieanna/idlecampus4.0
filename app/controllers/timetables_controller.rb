class TimetablesController < ApplicationController

	def new
		@group = Group.find(params[:group_id])
		@timetable = @group.build_timetable
	end

	# def create
#     @group = Group.find(params[:group_id])
#       @timetable = @group.build_timetable(params[:timetable])
#       if @timetable.save
#         flash[:notice] = "Timetable has been created."
#         redirect_to [@group, @timetable]
#       else
#         flash[:alert] = "Timetable has not been created."
#         render "new"
#       end
#     end
    
    def create

      # db = SQLite3::Database.new('db/development.sqlite3')
      entries = ActiveSupport::JSON.decode(params['timetable']["entries"])
      p entries
      members = params['timetable']["members"]

      group = Group.find_by_group_code(params['timetable']["group"]["group_code"])
      
      timetable = group.timetable
      if not timetable
        timetable = Timetable.create
      end

      p group
      if group
        entries.each do |ent|

          ent.each do |en|

            en.each do |entry|
              p entry
              entry.each {

                  |key, value|
                p key
                p value
                c = ClassTiming.where(:to_hours => entry['to_hours'], :to_minutes => entry['to_minutes'], :from_hours => entry['from_hours'], :from_minutes => entry['from_minutes']).first
                if not c
                  c = ClassTiming.create(:to_hours => entry['to_hours'], :to_minutes => entry['to_minutes'], :from_hours => entry['from_hours'], :from_minutes => entry['from_minutes'])
                end
                small_group = SmallGroup.find_by_name(entry['batch'])
                if not small_group
                  small_group = SmallGroup.create(:name => entry['batch'])
                end
                weekday = Weekday.find_by_name(entry['weekday'])
                if not weekday
                  weekday = Weekday.create(:name => entry['weekday'])
                end

                timetableentry = TimetableEntry.where(:timetable_id => timetable.id, :weekday_id => weekday.id, :class_timing_id => c.id, :small_group_id => small_group.id).first

                if not timetableentry
                  timetableentry = TimetableEntry.create
                end
              
                if key != "from_hours" && key != "from_minutes" && key != "to_minutes" && key != "to_hours" && key != "weekday" && key != "$$hashKey" && key != "batch"
                  f = Field.find_by_name(key)
                  if not f
                    f = Field.create(:name => key)
                    timetable.fields << f
                  end
                  sql = "CREATE TABLE IF NOT EXISTS #{key}(id INTEGER PRIMARY KEY AUTOINCREMENT,name text(20),P_Id int,FOREIGN KEY (P_Id) REFERENCES TimetableEntry(id))"
                  ActiveRecord::Base.connection.execute(sql)
                  # results = db.execute("CREATE TABLE IF NOT EXISTS #{key}(id INTEGER PRIMARY KEY AUTOINCREMENT,name text(20),P_Id int,FOREIGN KEY (P_Id) REFERENCES TimetableEntry(id))")
                  sql = "INSERT INTO #{key} (name,P_id) VALUES ('#{value}',#{timetableentry.id})"
                  ActiveRecord::Base.connection.execute(sql)
                  # results = db.execute("INSERT INTO #{key} (name,P_id) VALUES ('#{value}',#{timetableentry.id})")
                  k = Class.new(ActiveRecord::Base) do
                    self.table_name = key
                    belongs_to :timetable_entry
                  end

                end
                timetableentry.weekday = weekday
                timetableentry.small_group = small_group
                timetableentry.class_timing = c
                timetableentry.timetable = timetable
                timetableentry.save
              }


            end
          end
        end
        group.timetable = timetable
        timetable.save
        group.save
        devices = []
        if members
        members.each do |member|
          user = User.find_by_jabber_id(member)
          device = user.device_identifier
          devices << device
        end
            timetable_hash = {}
            entries_hash = {}
            entries_hash["devices"] = devices
            entries_hash["message"] = 'http://idlecampus.com/timetable/get_timetable_for_group?group='+params['timetable']["group"]["group_code"]
            timetable_hash["push"] = entries_hash
            p timetable_hash
            @devices = ActiveSupport::JSON.encode(timetable_hash)

        p "CCCCCCCCCC"

        p request.fullpath
        p request.domain
        p request.base_url
        p request.original_fullpath

            puts "timetable push"

            uri = URI('http://developer.idlecampus.com/push/push1')
             p "UUUUUUUUUUURRRRRRRRRR"

            headers = { "Content-Type" => "application/json"}
                          http = Net::HTTP.new(uri.host, uri.port)


                                     resp, dat = http.post(uri.path, timetable_hash.to_json, headers)

        end
        end

      render :text => "saved"
    end

   private
     def timetable_params
        params.require(:timetable)
     end
end
