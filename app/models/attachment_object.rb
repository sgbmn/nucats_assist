class AttachmentObject < ActiveRecord::Base
  self.table_name = 'attachments_objects'
  self.primary_key = 'id'

  attr_accessible :attachments_id,
                  :objects_name,
                  :objects_id,
                  :created_by,
                  :created_on

  belongs_to :attachment, :foreign_key => 'attachments_id'
end
