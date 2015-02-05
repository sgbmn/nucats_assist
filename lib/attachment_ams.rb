class AttachmentAms

  require 'ams'

  def initialize
    @ams = Ams.new
    @ams.config = NucatsAssist::Application.config.ams
  end

  def create( uploaded_file, objects_name, objects_id, type=nil )

    name =  uploaded_file.original_filename
    file =  uploaded_file.read
    result = @ams.create( name, file )
    data = result['data']

    attachment = Attachment.new(
      :file_name => name,
      :file_id => data['FILE_ID'],
      :file_revision_id => data['FILE_REVISION_ID'],
      :objects_name => objects_name,
      :objects_id => objects_id,
      # :file_size => uploaded_file.size,
      :active => 1,
      :content_type => type
    )
    attachment.save(attachment)

    return attachment
  end

end