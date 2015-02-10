class AttachmentsController < ApplicationController
  require 'ams'

  respond_to :json
  before_filter :ams_config

  def ams_config
    @ams = Ams.new
    @ams.config = NucatsAssist::Application.config.ams
  end

  def index
    # attachments = Attachment.where({ :objects_name => params[:objects_name], :objects_id => params[:objects_id] })
    # respond_with(attachments)
  end

  def destroy
    # attachment = Attachment.find params[:id]
    # attachment.destroy
    # render :json => { :result => 'success' }
  end

  def show
    attachment = Attachment.where({ :file_revision_id => params[:id]}).first
    send_data Base64.decode64(@ams.get(params[:id])['data']['REVISION']), :type => '', :filename => attachment.file_name, disposition: 'attachment'
  end

  def create
    uploadedFile = params[:files]
    name =  uploadedFile[0].original_filename
    file =  uploadedFile[0].read
    result = @ams.create( name, file )
    data = result['data']

    attachment = Attachment.new(
      :file_name => name,
      :file_id => data['FILE_ID'],
      :file_revision_id => data['FILE_REVISION_ID'],
      :objects_name => params[:objects_name],
      :objects_id => params[:objects_id],
      # :file_size => uploadedFile[0].size
      :active => 1,
    )
    attachment.save(attachment)

    render :json => {files: attachment.as_json}.to_json
  end

end