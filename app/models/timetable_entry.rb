class TimetableEntry < ActiveRecord::Base
	belongs_to :timetable
	validates :timetable_id, presence: true
	belongs_to :weekday
	belongs_to :subject
	belongs_to :teacher
	belongs_to :room
  belongs_to :location
	belongs_to :class_timing
  belongs_to :small_group
  has_many :timetable_field_values

   def self.create_timetable_entries_with(timetable,entry)
        
      
      
       
   end

   def self.create_field(timetableentry,key,value)
      if key != "from_hours" && key != "from_minutes" && key != "to_minutes" && key != "to_hours" && key != "weekday" && key != "$$hashKey" && key != "batch"
        f = Field.find_by_name(key)
        if not f
          f = Field.create(:name => key)
          timetableentry.timetable.fields << f
        end
        sql = "CREATE TABLE IF NOT EXISTS #{key}(id INTEGER PRIMARY KEY AUTOINCREMENT,name text(20),P_Id int,FOREIGN KEY (P_Id) REFERENCES TimetableEntry(id))"
        ActiveRecord::Base.connection.execute(sql)
      
        sql = "INSERT INTO #{key} (name,P_id) VALUES ('#{value}',#{timetableentry.id})"
        ActiveRecord::Base.connection.execute(sql)
       
        create_record_for(key)
        
       

      end
    end

    def self.create_record_for(key)
      k = Class.new(ActiveRecord::Base) do
        self.table_name = key
        belongs_to :timetable_entry
      end
    end
  
end
