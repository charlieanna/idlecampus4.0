class Timetable < ActiveRecord::Base
	belongs_to :group
	has_many :timetable_entries, dependent: :destroy
  has_and_belongs_to_many :fields
  has_many :weekdays,through: :timetable_entries
  # def to_json(options={})
  # 	"dasda"
  # end

  def create_timetable(entries)

  	  entries.each do |ent|

          ent.each do |en|

            en.each do |entry|
             
              class_timing = ClassTiming.find_or_create_by(:to_hours => entry['to_hours'], :to_minutes => entry['to_minutes'], :from_hours => entry['from_hours'], :from_minutes => entry['from_minutes'])
     
              small_group = SmallGroup.find_or_create_by(name:entry['batch'])
      
              weekday = Weekday.find_or_create_by(name: entry['weekday']) 
              
              timetableentry = TimetableEntry.find_or_create_by(:timetable_id => self.id, :weekday_id => weekday.id, :class_timing_id => class_timing.id, :small_group_id => small_group.id)
 
              entry.each do
                   |key,value|
        
                create_field(timetableentry,key,value)
      
                timetableentry.save
       
              end
              


            end
          end
        end


  end


  
    
    def create_field(timetableentry,key,value)
      if key != "from_hours" && key != "from_minutes" && key != "to_minutes" && key != "to_hours" && key != "weekday" && key != "$$hashKey" && key != "batch"
        f = Field.find_by_name(key)
        if not f
          f = Field.create(:name => key)
          self.fields << f
        end
        sql = "CREATE TABLE IF NOT EXISTS #{key}(id INTEGER PRIMARY KEY AUTOINCREMENT,name text(20),P_Id int,FOREIGN KEY (P_Id) REFERENCES TimetableEntry(id))"
        ActiveRecord::Base.connection.execute(sql)
      
        sql = "INSERT INTO #{key} (name,P_id) VALUES ('#{value}',#{timetableentry.id})"
        ActiveRecord::Base.connection.execute(sql)
       
        create_record_for(key)
        
       

      end
    end
    
    def create_record_for(key)
      k = Class.new(ActiveRecord::Base) do
        self.table_name = key
        belongs_to :timetable_entry
      end
    end
    
   
    
    def get_entries(timetable)
      entries = time.timetable_entries.includes(:class_timing).includes(:weekday).includes(:small_group)
      entries.sort{ |a, b|

        a.class_timing <=> b.class_timing



      }
      return entries
    end
    
    def build_f(fields)
      f = []
      fields.each do |field|

        f.push(Class.new(ActiveRecord::Base) do
          self.table_name = field.name
          #belongs_to :timetable_entry
        end)
      

      end
      return f
    end


end
