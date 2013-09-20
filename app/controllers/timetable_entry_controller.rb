require 'rubygems'
require 'sqlite3'
class TimetableEntryController < ApplicationController
  def new
    @entry = TimetableEntry.new


    #db.execute_batch( results )

  end

  def create
    p params

    entries = params[:entries]
    @t = TimetableEntry.create

    db = SQLite3::Database.new('db/development.sqlite3')
    entries.each do |entry|
      f = Field.create(:name=>entry)
      @t.fields << f
      results = db.execute("CREATE TABLE #{entry}(O_Id INTEGER PRIMARY KEY AUTOINCREMENT,name text(20),P_Id int,FOREIGN KEY (P_Id) REFERENCES TimetableEntry(id))")


    end
  end


  def addValueToEntry
    p @t
    db = SQLite3::Database.new('db/development.sqlite3')
    entry = params[:entry]
    value = params[:value]
    p      @t.id
    results = db.execute("INSERT INTO #{entry} (name,P_id) VALUES ('#{value}',#{@t.id})")
  end
end
