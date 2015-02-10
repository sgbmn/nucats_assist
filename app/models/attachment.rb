class Attachment < ActiveRecord::Base

  attr_accessible :file_name, :file_id, :file_revision_id, :objects_name, :objects_id, :active, :file_type_id,
  :type#, :file_size

  has_many :attachment_objects, :foreign_key => 'attachments_id'
  # validates :content_type, inclusion: {in: %w(application/pdf 
  #   application/vnd.openxmlformats-officedocument.wordprocessingml.document application/msword),
  #   :message => "%{value} is not a valid file type" }

  def as_json(options = {})
    {
      name: self.file_name,
      # size: self.file_size.to_i,
      url: '/portal/funding_opportunities/attachments/' + self.file_revision_id,
      thumbnailUrl: "\/\/example.org\/thumbnails\/picture1.jpg",
      deleteUrl: "/attachments/" + self.id.to_s,
      deleteType: "DELETE"
    }
  end

  def url
    '/portal/funding_opportunities/attachments/' + self.file_revision_id
  end

  # def content_type
  #   read_attribute :type
  # end

  # def content_type=(ct)
  #   write_attribute :type, ct
  # end

  def updated_at
    updated = read_attribute(:modified_on)
    if updated.nil? or updated.blank? 
      read_attribute(:created_on)
    else
      updated
    end
  end

end