class Note < ActiveRecord::Base
	include Rails.application.routes.url_helpers

  mount_uploader :file, FileUploader
 
  belongs_to :group
  
  def to_jq_upload
  {
     "name" => read_attribute(:file),
    "size" => file.size,
    "url" => file.url,
   
     "delete_url" => note_path(:id => id),
    "delete_type" => "DELETE" 
   }
  end
end