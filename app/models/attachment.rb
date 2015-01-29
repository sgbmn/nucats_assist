class Attachment < ActiveRecord::Base

  attr_accessible :file_name, :file_id, :file_revision_id, :objects_name, :objects_id, :active, :file_type_id,
  :type#, :file_size

  has_many :attachment_objects,
           :foreign_key => 'attachments_id'

  def as_json(options = {})
    {
      name: self.file_name,
      # size: self.file_size.to_i,
      url: '/portal/funding_opportunities/attachments/' + self.file_revision_id,
      thumbnail_url: "\/\/example.org\/thumbnails\/picture1.jpg",
      delete_url: "/attachments/" + self.id.to_s,
      delete_type: "DELETE"
    }
  end

  def updated_at
    updated = read_attribute(:modified_on)
    if updated.nil? or updated.blank? 
      read_attribute(:created_on)
    else
      updated
    end
  end

end