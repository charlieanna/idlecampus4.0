class FieldEntry
	def initialize(name,values)
		@name = name
		@values = values
	end

	def build
		 field_entry = {}
     field_entry["name"] = @name
     field_entry["values"] = @values.uniq
     return field_entry
	end
end
