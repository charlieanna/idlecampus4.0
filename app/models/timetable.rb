class Timetable < ActiveRecord::Base
  attr_accessor :message, :members
  belongs_to :group
  has_many :timetable_entries, dependent: :destroy
  has_and_belongs_to_many :fields
  has_many :weekdays, through: :timetable_entries
  # def to_json(options={})
  # 	"dasda"
  # end

  after_save :send_push


  def send_push

    Push.new(@members, @message).send_push
  end

  def build_timetable_entries(entries)
     entries.each do |ent|

      ent.each do |en|

        en.each do |entry|

          class_timing = ClassTiming.find_or_create_by(:to_hours => entry['to_hours'], :to_minutes => entry['to_minutes'], :from_hours => entry['from_hours'], :from_minutes => entry['from_minutes'])

          small_group = SmallGroup.find_or_create_by(name: entry['batch'])

          weekday = Weekday.find_or_create_by(name: entry['weekday'])

          timetableentry = TimetableEntry.find_or_create_by(:timetable_id => self.id, :weekday_id => weekday.id, :class_timing_id => class_timing.id, :small_group_id => small_group.id)

          entry.each do
          |key, value|

            create_field(timetableentry, key, value)

            timetableentry.save

          end


        end
      end
    end
  end
  def create_timetable(params)

    entries = ActiveSupport::JSON.decode(params['timetable']["entries"])

    members = params['timetable']["members"]

    self.members = members

    message = 'http://idlecampus.com/groups/'+"RNHVQR"+'/timetable.json'

    self.message = message

    build_timetable_entries(entries)

 end


  def create_field(timetableentry, key, value)
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


  def get_entries
    entries = self.timetable_entries.includes(:class_timing).includes(:weekday).includes(:small_group)
    entries.sort { |a, b|

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

  def build_timetable_hash

    weekdays = []
    batches = []
    field_entries = []
    field_entry = {}
    field_entry["name"] = ""
    field_entry["values"] = []


    if self

      f = []
      entries_array = []

      build_f(fields)
      entries = get_entries


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
            weekdays << b.weekday.name
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
          weekdays << a.weekday.name
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
          weekdays << a.weekday.name
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
        p entries_array.length
        while isFound && j < entries_array.length
          p j
          b = entries_array[j]
          #p "BBBBBBBBB"
          #p a
          #p b
          first_element_b = b[0]
          if first_element_a["to_hours"] == first_element_b["to_hours"] && first_element_a["to_minutes"] == first_element_b["to_minutes"] && first_element_a["from_minutes"] == first_element_b["from_minutes"] && first_element_a["from_hours"] == first_element_b["from_hours"]


            arr.insert(0, b)


            p "ARRAY"
            p arr
            entries_array.delete(b)
            p entries_array
            #j = j - 1
          else
            entries_array.delete(a)
            p entries_array
            arr.insert(0, a)
            p "ELSE ARRAY"
            p arr
            #entries_array[i] = arr
            entries_array.insert(i, arr)
            p entries_array
            i = i + 1
            isFound = false
          end
        end
        if j == entries_array.length
          arr.insert(0, a)
          p "BREAK ARRAY"
          p arr
          entries_array[i] = arr
          break
        end


      end
      p "MMMMMMMMMMMM"
      p entries_array
    end
    timetable_hash = {}
    entries_hash = {}
    entries_hash["group_code"] = group.group_code
    entries_hash["field_entries"] = field_entries.uniq
    entries_hash["entries"] = entries_array
    entries_hash["weekdays"] = weekdays.uniq
    entries_hash["batches"] = batches.uniq.compact
    timetable_hash["timetable"] = entries_hash
    @timetable = ActiveSupport::JSON.encode(timetable_hash)
  end


end
