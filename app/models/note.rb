class Note < ActiveRecord::Base
  attr_accessor :note, :members
  include Rails.application.routes.url_helpers
  mount_uploader :file, FileUploader
  process_in_background :file
  belongs_to :group
  def to_jq_upload
    {
     'name' => read_attribute(:file),
     'size' => file.size,
     'url' => file.url,
     'delete_url' => note_path(id: id),
     'delete_type' => 'DELETE'
    }
  end
  after_save :send_push
  def send_push
    args = {}
    args['from'] = group.name
    args['members'] = members
    args['message'] = note
    args['app'] = "note"
    puts args
    # Push.new(args['members'], args['message'], args['app']).send_push
    PygmentsWorker.perform_async(args)
  end
end
