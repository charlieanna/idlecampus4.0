    # Creating 6 users. 3 colleges. 6 batches or 2 batches for each college. putting each user in different branches. there are 6
    # 6 batches so there will be 6 different timetables.
    #db = SQLite3::Database.new('db/development.sqlite3')
    #timetable = Timetable.new


    group = Group.create(:name => "grougrop")
    #group.timetable = timetable
    #timetable.save

    user1 = User.new(:jabber_id => "ankothari@idlecampus.com", :email => "ankothari@gmail.com")

    user1.groups << group
    user1.save


    #f = []
    #keys = ["Teacher", "Student", "Room"]
    #
    #keys.each do |key|
    #
    #
    #  results = db.execute("CREATE TABLE IF NOT EXISTS #{key}(id INTEGER PRIMARY KEY AUTOINCREMENT,name text(20),P_Id int,FOREIGN KEY (P_Id) REFERENCES TimetableEntry(id))")
    #  field1 = Field.create(:name => key)
    #
    #  #t1.fields << field1
    #  timetable.fields << field1
    #
    #  #f.push(Class.new(ActiveRecord::Base) do
    #  #  self.table_name = key
    #  #  #belongs_to :timetable_entry
    #  #end)
    #end
    #
    #weekday1 = Weekday.create(:name => "Monday")
    #weekday2 = Weekday.create(:name => "Tuesday")
    #weekday3 = Weekday.create(:name => "Wednesday")
    #weekday4 = Weekday.create(:name => "Thursday")
    #weekday5 = Weekday.create(:name => "Friday")
    #weekday6 = Weekday.create(:name => "Saturday")
    #
    #
    #ct1 = ClassTiming.create(:to_hours=>11,:to_minutes=>0,:from_hours=>9,:from_minutes=>0)
    #ct2 = ClassTiming.create(:to_hours=>13,:to_minutes=>0,:from_hours=>11, :from_minutes=> 0)
    #ct3 = ClassTiming.create(:to_hours=>15,:to_minutes=>0,:from_hours=> 13, :from_minutes=> 0)
    #ct4 = ClassTiming.create(:to_hours=>16,:to_minutes=> 0, :from_hours=> 15,:from_minutes=> 0)
    #ct5 = ClassTiming.create(:to_hours=>17,:to_minutes=>0,:from_hours=> 16, :from_minutes=> 0)
    #ct6 = ClassTiming.create(:to_hours=>18,:to_minutes=>0, :from_hours=>17, :from_minutes=> 0)
    #
    #teachers = ["Ankur"]
    #subjects = ["Maths"]
    #rooms =["Room 1"]
    #
    #t1 = TimetableEntry.create
    #
    #
    #teachers.each do |value|
    #  results = db.execute("INSERT INTO #{keys[0]} (name,P_id) VALUES ('#{value}',#{t1.id})")
    #end
    #
    #
    #subjects.each do |value|
    #  results = db.execute("INSERT INTO #{keys[1]} (name,P_id) VALUES ('#{value}',#{t1.id})")
    #end
    #
    #
    #rooms.each do |value|
    #  results = db.execute("INSERT INTO #{keys[2]} (name,P_id) VALUES ('#{value}',#{t1.id})")
    #end
    #
    #
    #t1.weekday = weekday1
    #t1.class_timing = ct1
    #t1.timetable = timetable
    #t1.save
    #
    #
    #time = group.timetable
    #entries = time.timetable_entries
    #fields = time.fields
    #f = []
    #fields.each do |field|
    #
    #  f.push(Class.new(ActiveRecord::Base) do
    #    self.table_name = field.name
    #    #belongs_to :timetable_entry
    #  end)
    #
    #end
    #
    #
    #t1 = TimetableEntry.create
    #
    #
    #teachers.each do |value|
    #  results = db.execute("INSERT INTO #{keys[0]} (name,P_id) VALUES ('#{value}',#{t1.id})")
    #end
    #
    #
    #subjects.each do |value|
    #  results = db.execute("INSERT INTO #{keys[1]} (name,P_id) VALUES ('#{value}',#{t1.id})")
    #end
    #
    #
    #rooms.each do |value|
    #  results = db.execute("INSERT INTO #{keys[2]} (name,P_id) VALUES ('#{value}',#{t1.id})")
    #end
    #
    #
    #t1.weekday = weekday1
    #t1.class_timing = ct1
    #t1.timetable = timetable
    #t1.save
    #
    #
    #time = group.timetable
    #entries = time.timetable_entries
    #fields = time.fields
    #f = []
    #fields.each do |field|
    #
    #  f.push(Class.new(ActiveRecord::Base) do
    #    self.table_name = field.name
    #    #belongs_to :timetable_entry
    #  end)
    #
    #end
    #
    #
    #
    #t1 = TimetableEntry.create
    #
    #
    #teachers.each do |value|
    #  results = db.execute("INSERT INTO #{keys[0]} (name,P_id) VALUES ('#{value}',#{t1.id})")
    #end
    #
    #
    #subjects.each do |value|
    #  results = db.execute("INSERT INTO #{keys[1]} (name,P_id) VALUES ('#{value}',#{t1.id})")
    #end
    #
    #
    #rooms.each do |value|
    #  results = db.execute("INSERT INTO #{keys[2]} (name,P_id) VALUES ('#{value}',#{t1.id})")
    #end
    #
    #
    #t1.weekday = weekday1
    #t1.class_timing = ct1
    #t1.timetable = timetable
    #t1.save
    #
    #
    #time = group.timetable
    #entries = time.timetable_entries
    #fields = time.fields
    #f = []
    #fields.each do |field|
    #
    #  f.push(Class.new(ActiveRecord::Base) do
    #    self.table_name = field.name
    #    #belongs_to :timetable_entry
    #  end)
    #
    #end
    #
    #
    #t1 = TimetableEntry.create
    #
    #
    #teachers.each do |value|
    #  results = db.execute("INSERT INTO #{keys[0]} (name,P_id) VALUES ('#{value}',#{t1.id})")
    #end
    #
    #
    #subjects.each do |value|
    #  results = db.execute("INSERT INTO #{keys[1]} (name,P_id) VALUES ('#{value}',#{t1.id})")
    #end
    #
    #
    #rooms.each do |value|
    #  results = db.execute("INSERT INTO #{keys[2]} (name,P_id) VALUES ('#{value}',#{t1.id})")
    #end
    #
    #
    #t1.weekday = weekday1
    #t1.class_timing = ct1
    #t1.timetable = timetable
    #t1.save
    #
    #
    #time = group.timetable
    #entries = time.timetable_entries
    #fields = time.fields
    #f = []
    #fields.each do |field|
    #
    #  f.push(Class.new(ActiveRecord::Base) do
    #    self.table_name = field.name
    #    #belongs_to :timetable_entry
    #  end)
    #
    #end
    #
    #
    #t1 = TimetableEntry.create
    #
    #
    #teachers.each do |value|
    #  results = db.execute("INSERT INTO #{keys[0]} (name,P_id) VALUES ('#{value}',#{t1.id})")
    #end
    #
    #
    #subjects.each do |value|
    #  results = db.execute("INSERT INTO #{keys[1]} (name,P_id) VALUES ('#{value}',#{t1.id})")
    #end
    #
    #
    #rooms.each do |value|
    #  results = db.execute("INSERT INTO #{keys[2]} (name,P_id) VALUES ('#{value}',#{t1.id})")
    #end
    #
    #
    #t1.weekday = weekday1
    #t1.class_timing = ct1
    #t1.timetable = timetable
    #t1.save
    #
    #
    #time = group.timetable
    #entries = time.timetable_entries
    #fields = time.fields
    #f = []
    #fields.each do |field|
    #
    #  f.push(Class.new(ActiveRecord::Base) do
    #    self.table_name = field.name
    #    #belongs_to :timetable_entry
    #  end)
    #
    #end
    #
    #
    #t1 = TimetableEntry.create
    #
    #
    #teachers.each do |value|
    #  results = db.execute("INSERT INTO #{keys[0]} (name,P_id) VALUES ('#{value}',#{t1.id})")
    #end
    #
    #
    #subjects.each do |value|
    #  results = db.execute("INSERT INTO #{keys[1]} (name,P_id) VALUES ('#{value}',#{t1.id})")
    #end
    #
    #
    #rooms.each do |value|
    #  results = db.execute("INSERT INTO #{keys[2]} (name,P_id) VALUES ('#{value}',#{t1.id})")
    #end
    #
    #
    #t1.weekday = weekday1
    #t1.class_timing = ct1
    #t1.timetable = timetable
    #t1.save
    #
    #
    #time = group.timetable
    #entries = time.timetable_entries
    #fields = time.fields
    #f = []
    #fields.each do |field|
    #
    #  f.push(Class.new(ActiveRecord::Base) do
    #    self.table_name = field.name
    #    #belongs_to :timetable_entry
    #  end)
    #
    #end
    #
    #entries_array = []
    #entries.each do |entry|
    #  entry_hash = {}
    #  entry_hash["weekday"] = entry.weekday.name
    #  f.each do |field|
    #    d = field.where("P_Id" => entry.id)
    #
    #    entry_hash[field.table_name] = d.first.name
    #
    #  end
    #  entry_hash["to_hours"] = entry.class_timing.to_hours
    #  entry_hash["to_minutes"] = entry.class_timing.to_minutes
    #  entry_hash["from_minutes"] = entry.class_timing.from_minutes
    #  entry_hash["from_hours"] = entry.class_timing.from_hours
    #  entries_array << entry_hash
    #end
    #
    #
    #timetable_hash = {}
    #entries_hash = {}
    #entries_hash["entries"] = entries_array
    #timetable_hash["timetable"] = entries_hash
    #
    #@timetable = ActiveSupport::JSON.encode(timetable_hash)
    #p @timetable
    #
    #
    #timetable.save