require 'rubygems'
require 'net/http'
require 'json'
require "net/https"
require "uri"
class TimetableController < ApplicationController
  respond_to :json

  def send_message
  end

  def get_timetable_for_teacher
    teacher = Teacher.find_by_name(params[:teacher])

    college = College.find_by_name(params[:college])
    batch = Batch.find_by_name(params[:batch])
    entries = TimetableEntry.where(:college_id => college.id, :batch_id => batch.id)
    # create a hash here
    entries_array = []
    entries.each do |entry|
      entry_hash = {}
      entry_hash["weekday"] = entry.weekday
      entry_hash["subject"] = entry.subject
      entry_hash["teacher"] = entry.teacher
      entry_hash["room"] = entry.room
      entry_hash["to_hours"] = entry.class_timing.to_hours
      entry_hash["to_minutes"] = entry.class_timing.to_minutes
      entry_hash["from_minutes"] = entry.class_timing.from_minutes
      entry_hash["from_hours"] = entry.class_timing.from_hours
      entries_array << entry_hash
    end


    timetable_hash = {}
    entries_hash = {}
    entries_hash["entries"] = entries_array
    timetable_hash["timetable"] = entries_hash

    @timetable = ActiveSupport::JSON.encode(timetable_hash)

    render :json => @timetable
  end

  # when the user logins the user credentials are created on the idlecampus server. and when the device is registered with the apple when it recieves the deviceToken a new device is created on the server with idlecampus. 
  #  user = User.new(:name,:password)
  #   device = Device.new(:type,:deviceToken,:udid)
  def create_college_and_batch
    # user = User.find_by_jabber_id(params[:jabber_id])

    college = College.find_by_name(params[:college])
    if not (college)
      college = College.create(name: params[:college])
    end
    batch= Batch.create(name: params[:batch])
    college.batches << batch
    render :nothing => true
  end

  def register_college_and_batch_for_user
    user = User.find_by_jabber_id(params[:jabber_id])
    college = College.find_by_name(params[:college])
    batch = Batch.find_by_name(params[:batch])
    user.college = college
    user.batch = batch
    user.save
    render :nothing => true
  end

  def register_group_to_user
    user = User.find_by_jabber_id(params[:jabber_id])
    group = Group.find_by_name(params[:group])
    user.group = group
    user.save
    render :nothing => true
  end

  def find_college_and_batch
    college = College.find_by_name(params[:college])
    batch = Batch.find_by_name(params[:batch])

    render :nothing => true
  end

  def find_college_and_batch_for_jabber_id
    user = User.find_by_jabber_id(params[:jabber_id])


    jabber_id_hash = {}
    entry_hash = {}

    entry_hash["college"] = user ? user.college.name : ""
    entry_hash["batch"] = user ? user.batch.name : ""
    jabber_id_hash["jabber_id"] = entry_hash

    @jabber_id = ActiveSupport::JSON.encode(jabber_id_hash)

    render :json => @jabber_id

  end

  def timetable
    puts "AAAAAAAAAAAAAAA"
    p params
    @college = params[:college]
    @batch = params[:batch]
    @cookies = cookies
    gon.college = params[:college]
    gon.batch = params[:batch]
    p @cookies
  end

  def get_timetable_for_college_and_batch
    college = College.find_by_name(params[:college])
    batch = Batch.find_by_name(params[:batch])
    entries = TimetableEntry.where(:college_id => college.id, :batch_id => batch.id)
    # create a hash here
    entries_array = []
    entries.each do |entry|
      entry_hash = {}
      entry_hash["weekday"] = entry.weekday
      entry_hash["subject"] = entry.subject
      entry_hash["teacher"] = entry.teacher
      entry_hash["room"] = entry.room
      entry_hash["to_hours"] = entry.class_timing.to_hours
      entry_hash["to_minutes"] = entry.class_timing.to_minutes
      entry_hash["from_minutes"] = entry.class_timing.from_minutes
      entry_hash["from_hours"] = entry.class_timing.from_hours
      entries_array << entry_hash
    end


    timetable_hash = {}
    entries_hash = {}
    entries_hash["entries"] = entries_array
    timetable_hash["timetable"] = entries_hash

    @timetable = ActiveSupport::JSON.encode(timetable_hash)

    render :json => @timetable


  end

  def get_timetable_for_group
    p params
    group =  params["group"]
    p group
    group = Group.find_by_group_code(group)
    time = group.timetable
    weekdays = []
    batches = []
    field_entries = []
    field_entry = {}
    field_entry["name"] = ""
    field_entry["values"] = []
    if time
    fields = time.fields
    f = []
    entries_array = []

    fields.each do |field|

      f.push(Class.new(ActiveRecord::Base) do
        self.table_name = field.name
        #belongs_to :timetable_entry
      end)

    end

      entries = time.timetable_entries.includes(:class_timing).includes(:weekday).includes(:small_group)
      entries.sort{ |a, b|

        a.class_timing <=> b.class_timing



      }





      check = []
      i = 0
      p "LLLLLLEEEEEE"
      p entries.length

      while i < entries.length
        e = []
        #fir st sort the elements baed on the classtimings only. and then group basd on them and then do the below sorting
        #each element has not been met with the condition so found = false. and when the condition meets we have found a match and we add the element t an array that met the condn.
        # but we dont add the parent element
        found = false
        entry = entries[i]


        a = entry


        j = i

        while j < entries.length

          b = entries[j]




          if a.weekday == b.weekday and a.class_timing == b.class_timing && a.small_group != b.small_group
            found = true
            entry_hash = {}
            entry_hash["weekday"] = b.weekday.name
            weekdays <<  b.weekday.name
            f.each do |field|
              d = field.where("P_Id" => b.id)
              p "DDDDDDDD"

              entry_hash[field.table_name] = d.first.name if d.length > 0
              field_entry = {}
              field_entry["name"] = field.table_name
              field_entry["values"] = field.uniq.pluck(:name)
              field_entries << field_entry
            end
            entry_hash["batch"] = b.small_group.name
            batches << b.small_group.name
            entry_hash["to_hours"] = b.class_timing.to_hours
            entry_hash["to_minutes"] = b.class_timing.to_minutes
            entry_hash["from_minutes"] = b.class_timing.from_minutes
            entry_hash["from_hours"] = b.class_timing.from_hours
            e << entry_hash

            check << entry_hash
          end
          j = j + 1
        end
        #agar ek baar bhi true hua toh element ko array me daaldo. aur agar found nahi mila toh usey seedhe parent array me daalo
        if found
          entry_hash = {}
          entry_hash["weekday"] = a.weekday.name
          weekdays <<  a.weekday.name
          f.each do |field|
            d = field.where("P_Id" => a.id)



            entry_hash[field.table_name] = d.first.name if d.length > 0
            field_entry = {}
            field_entry["name"] = field.table_name
            field_entry["values"] = field.uniq.pluck(:name)
            field_entries << field_entry

          end
          entry_hash["batch"] = a.small_group.name
          batches << a.small_group.name
          entry_hash["to_hours"] = a.class_timing.to_hours
          entry_hash["to_minutes"] = a.class_timing.to_minutes
          entry_hash["from_minutes"] = a.class_timing.from_minutes
          entry_hash["from_hours"] = a.class_timing.from_hours
          e << entry_hash

          check << entry_hash
          #p e
          entries_array << e
          #p entries_array
        else

          entry_hash = {}
          entry_hash["weekday"] = a.weekday.name
          weekdays <<  a.weekday.name
          f.each do |field|
            d = field.where("P_Id" => a.id)


            entry_hash[field.table_name] = d.first.name if d.length > 0
            field_entry = {}
            field_entry["name"] = field.table_name
            field_entry["values"] = field.uniq.pluck(:name)
            field_entries << field_entry

          end
          entry_hash["batch"] = a.small_group.name
          batches << a.small_group.name
          entry_hash["to_hours"] = a.class_timing.to_hours
          entry_hash["to_minutes"] = a.class_timing.to_minutes
          entry_hash["from_minutes"] = a.class_timing.from_minutes
          entry_hash["from_hours"] = a.class_timing.from_hours
          #p e
          #p entry_hash
          #p check
          if check.include?(entry_hash)
           #p "AAAAAAAAAA"
          else
            e << entry_hash
            #p entries_array
          entries_array << e
          end
        end
        i = i + 1
      end

      #now group all the entries with same class_timings together and put them in the array
      #find the first element of this array and then compare it to the i + 1 element ka first array
      #  compare the class_timings of both these elements. if they are same then put them in a same array
      #p "LLLLLLLLLLLLL"
      p entries_array
      i = 0
      while i < entries_array.length
        #loop thru each element

        a = entries_array[i]
        p "AAAAAAAAA"

        #p entries_array
        p a
        first_element_a = a[0]
        arr = []
        isFound = true
        j = i + 1
        p i
        p j
        p  entries_array.length
        while isFound && j < entries_array.length
          p j
          b = entries_array[j]
          #p "BBBBBBBBB"
          #p a
          #p b
          first_element_b = b[0]
          if first_element_a["to_hours"] == first_element_b["to_hours"] && first_element_a["to_minutes"] == first_element_b["to_minutes"] && first_element_a["from_minutes"] == first_element_b["from_minutes"] && first_element_a["from_hours"] == first_element_b["from_hours"]


            arr.insert(0,b)


            p "ARRAY"
            p arr
            entries_array.delete(b)
            p entries_array
            #j = j - 1
          else
            entries_array.delete(a)
            p  entries_array
            arr.insert(0,a)
            p "ELSE ARRAY"
            p arr
            #entries_array[i] = arr
            entries_array.insert(i,arr)
            p  entries_array
            i = i + 1
            isFound = false
          end
        end
        if j == entries_array.length
          arr.insert(0,a)
          p "BREAK ARRAY"
          p arr
          entries_array[i] = arr
          break
        end


      end
      p "MMMMMMMMMMMM"
      p entries_array

      timetable_hash = {}
      entries_hash = {}
      entries_hash["group_code"] = group.group_code
      entries_hash["field_entries"] = field_entries.uniq
      entries_hash["entries"] = entries_array
      entries_hash["weekdays"] = weekdays.uniq
      entries_hash["batches"] = batches.uniq.compact
      timetable_hash["timetable"] = entries_hash
      p timetable_hash
      @timetable = ActiveSupport::JSON.encode(timetable_hash)

      render :json => @timetable

    else
      timetable_hash = {}
      entries_hash = {}
      entries_hash["group_code"] = group.group_code
      entries_hash["field_entries"] = []
      entries_hash["entries"] = []
      entries_hash["weekdays"] = []
      entries_hash["batches"] = []
      timetable_hash["timetable"] = entries_hash
      p timetable_hash
      @timetable = ActiveSupport::JSON.encode(timetable_hash)

      render :json => @timetable
    end
  end




  def new
    
  end

  def create

    db = SQLite3::Database.new('db/development.sqlite3')
    entries = ActiveSupport::JSON.decode(params['timetable']["entries"])
    p entries
    members = params['timetable']["members"]

    group = Group.find_by_group_code(params['timetable']["group"]["group_code"])
    debugger
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

                results = db.execute("CREATE TABLE IF NOT EXISTS #{key}(id INTEGER PRIMARY KEY AUTOINCREMENT,name text(20),P_Id int,FOREIGN KEY (P_Id) REFERENCES TimetableEntry(id))")

                results = db.execute("INSERT INTO #{key} (name,P_id) VALUES ('#{value}',#{timetableentry.id})")
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


#  def create
#    p params
#    users = ActiveSupport::JSON.decode( params['timetable']["users"])
#    p users
#
#
#    entries = ActiveSupport::JSON.decode(params['timetable']["entries"])
#
#    college = College.find_by_name(params['timetable']["college"])
#
#
#    batch = Batch.find_by_name(params['timetable']["batch"])
#    dbentries = TimetableEntry.where(college_id:college.id,batch_id:batch.id)
#    dbentries.each do |dbentry|
#      dbentry.destroy
#    end
#    entries.each do |entry|
#
#      weekday =  Weekday.find_by_name(entry['weekday'])
#      subject =  Subject.find_by_name(entry['subject'])
#      teacher =  Teacher.find_by_name(entry['teacher'])
#      room = Room.find_by_name(entry['room'])
#      c = ClassTiming.where(to_hours:entry['to_hours'],to_minutes:entry['to_minutes'],from_hours:entry['from_hours'],from_minutes:entry['from_minutes']).first
#
#
#      if not weekday
#        weekday =  Weekday.create(:name=>entry['weekday'])
#      end
#      if not subject
#        subject =  Subject.create(:name=>entry['subject'])
#      end
#      if not teacher
#        teacher =  Teacher.create(:name=>entry['teacher'])
#      end
#
#
#
#      if not room
#       room =  Room.create(:name=>entry['room'])
#     end
#     if not  c
#      c = ClassTiming.create(to_hours:entry['to_hours'],to_minutes:entry['to_minutes'],from_hours:entry['from_hours'],from_minutes:entry['from_minutes'])
#    end
#    timetableentry = TimetableEntry.where(college_id:college.id,batch_id:batch.id,room_id:room.id,teacher_id:teacher.id,subject_id:subject.id,weekday_id:weekday.id,class_timing_id:c.id).first
#
#    if not  timetableentry
#      p timetableentry
#      timetableentry = TimetableEntry.new
#      timetableentry.college = college
#      timetableentry.batch = batch
#    end
#    timetableentry.weekday = weekday
#    timetableentry.subject = subject
#    timetableentry.room = room
#    timetableentry.class_timing = c
#
#    timetableentry.teacher = teacher
#    timetableentry.save
#  end
#
#  entries_array = []
#   users.each do |jabber_id|
#      entry_hash = {}
#      user = User.find_by_jabber_id(jabber_id)
#      p user
#      p jabber_id
#      entry_hash["device_identifier"] = user.device_identifier
#
#      entries_array << entry_hash
#
#
#end
#
#    timetable_hash = {}
#    entries_hash = {}
#    entries_hash["devices"] = entries_array
#    entries_hash["message"] = 'http://10.124.4.51:3000/timetable/gettcb?college=mpstme&batch=electronics'
#    timetable_hash["push"] = entries_hash
#
#    @devices = ActiveSupport::JSON.encode(timetable_hash)
#
#
#
#
#    puts "timetable push"
#    uri = URI('http://idlecampus.com:8000/push/push')
#
#
#    headers = { "Content-Type" => "application/json"}
#                  http = Net::HTTP.new(uri.host, uri.port)
#
#
#                             resp, dat = http.post(uri.path, timetable_hash.to_json, headers)
#
## now send each member of the group a push
# render :nothing => true
#end


  def sendtt
    entries_array = []

    entry_hash = {}
    entry_hash["device_identifier"] = "6D005229-5FD3-4457-9872-F1A67C87D818"

    entries_array << entry_hash


    timetable_hash = {}
    entries_hash = {}
    entries_hash["devices"] = entries_array
    entries_hash["message"] = "timetable"
    timetable_hash["push"] = entries_hash

    @devices = ActiveSupport::JSON.encode(timetable_hash)


    puts "timetable push"

    uri = URI('http://developer.idlecampus.com/push/push')


    headers = {"Content-Type" => "application/json"}
    http = Net::HTTP.new(uri.host, uri.port)


    resp, dat = http.post(uri.path, timetable_hash.to_json, headers)


    render :nothing => true

  end

  def get_timetable_for_jabber_id
    # /timetable/get_timetable?college=mpstme&batch=electronics


    # will either get college id and batch id or college name and batch name. LEt us assume i am going to get the college name and the batch name
    user = User.find_by_jabber_id(params[:jabber_id])
    college = user.college
    batch = user.batch
    entries = TimetableEntry.where(:college_id => college.id, :batch_id => batch.id)
    # create a hash here
    entries_array = []
    entries.each do |entry|
      entry_hash = {}
      entry_hash["weekday"] = entry.weekday
      entry_hash["subject"] = entry.subject
      entry_hash["teacher"] = entry.teacher
      entry_hash["room"] = entry.room
      entry_hash["to_hours"] = entry.class_timing.to_hours
      entry_hash["to_minutes"] = entry.class_timing.to_minutes
      entry_hash["from_minutes"] = entry.class_timing.from_minutes
      entry_hash["from_hours"] = entry.class_timing.from_hours
      entries_array << entry_hash
    end


    timetable_hash = {}
    entries_hash = {}
    entries_hash["entries"] = entries_array
    timetable_hash["timetable"] = entries_hash

    p timetable_hash

    render :json => ActiveSupport::JSON.encode(timetable_hash)

    # {"timetable"=>{"entries"=>"[{\"subject\":\"dfg\",\"teacher\":\"gdfg\",\"room\":\"fdgdf\",\"weekday\":\"Monday\",\"starttime\":\"9\",\"endtime\":\"11\"},{\"subject\":\"fdgdf\",\"teacher\":\"fdgdf\",\"room\":\"ffdgfd\",\"weekday\":\"Tuesday\",\"starttime\":\"9\",\"endtime\":\"11\"},{\"subject\":\"dgdf\",\"teacher\":\"dfg\",\"room\":\"dfgf\",\"weekday\":\"Wednesday\",\"starttime\":\"9\",\"endtime\":\"11\"}]"}}

  end



end
