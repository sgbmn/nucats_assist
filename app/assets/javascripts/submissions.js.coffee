$ ->
  $('#submission_form').submit ->
    valid = true
    $('input:file').each ->
      fileType = $(this).val().split('.').pop().toLowerCase()
      if ($.inArray(fileType, ['pdf', 'doc', 'docx']) >= 0) or fileType == ''
        true
      else
        alert "Only pdf, doc, and docx file are allowed"
        valid = false
        false
    console.log valid
    
#   $('#fileupload').fileupload
#     dataType: 'json'
#     done: (e, data) ->
#       console.log data.result.files
#       for fil in data.result.files #, (index, file) ->
#         console.log file
#         $('<p/>').text(file.name).appendTo '#files'
#     progressall: (e, data) ->
#       progress = parseInt(data.loaded / data.total * 100, 10)
#       $('#progress .progress-bar').css 'width', progress + '%'
    
#   # 'use strict'
#   # # Change this to the location of your server-side upload handler:
#   # # var url = window.location.hostname === 'blueimp.github.io' ?
#   # #             '//jquery-file-upload.appspot.com/' : 'server/php/',
#   # uploadButton = $('<button/>')
#   # uploadButton.addClass('btn btn-primary')
#   # uploadButton.prop('disabled', true)
#   # uploadButton.text('Processing...')
#   # uploadButton.on 'click', ->
#   #   $this = $(this)
#   #   data = $this.data()
#   #   $this.off('click').text('Abort').on 'click', ->
#   #     $this.remove()
#   #     data.abort()
#   #   data.submit().always ->
#   #     $this.remove()

#   # upload = $('#fileupload').fileupload
#   #   # url: "//#{window.location.hostname}/portal/funding_opportunities/attachments"
#   #   dataType: 'json'
#   #   autoUpload: true
#   #   acceptFileTypes: /(\.|\/)(pdf|doc|docx)$/i
#   #   maxFileSize: 5000000
#   #   limitMultiFileUploads: 1
#   #   add: (e, data) ->
#   #     data.context = $('<div/>').appendTo('#files')
#   #     $.each data.files, (index, file) ->
#   #       node = $('<p/>').append($('<span/>').text(file.name))
#   #       if !index
#   #         node.append('<br>').append uploadButton.clone(true).data(data)
#   #       node.appendTo data.context
#   #   processalways: (e, data) ->
#   #     alert "hello"
#   #     index = data.index
#   #     file = data.files[index]
#   #     node = $(data.context.children()[index])
#   #     if file.preview
#   #       node.prepend('<br>').prepend file.preview
#   #     if file.error
#   #       node.append('<br>').append $('<span class="text-danger"/>').text(file.error)
#   #     if index + 1 == data.files.length
#   #       data.context.find('button').text('Upload').prop 'disabled', !!data.files.error
#   #   # progressall: (e, data) ->
#   #   #   progress = parseInt(data.loaded / data.total * 100, 10)
#   #   #   $('#progress .progress-bar').css 'width', progress + '%'
#   #   done: (e, data) ->
#   #     $.each data.result.files, (index, file) ->
#   #       if file.url
#   #         link = $('<a>').attr('target', '_blank').prop('href', file.url)
#   #         $(data.context.children()[index]).wrap link
#   #       else if file.error
#   #         error = $('<span class="text-danger"/>').text(file.error)
#   #         $(data.context.children()[index]).append('<br>').append error
#   #   # fail: (e, data) ->
#   #   #   $.each data.files, (index) ->
#   #   #     error = $('<span class="text-danger"/>').text('File upload failed.')
#   #   #     $(data.context.children()[index]).append('<br>').append error
  
#   # upload.prop('disabled', !$.support.fileInput).parent().addClass if $.support.fileInput then undefined else 'disabled'

# haml
# / / The fileinput-button span is used to style the file input field as button
# / %span.btn.btn-success.fileinput-button
# /   %i.glyphicon.glyphicon-plus
# /   %span Select files...
# /   / The file input field used as target for the file upload widget
# /   %input#fileupload{:multiple => "multiple", :name => "files[]", :type => "file", data: { url: "//#{h request.host_with_port}/portal/funding_opportunities/attachments", 'form-data' => "{\"objects_name\": \"nucats_submission\", \"objects_id\": \"#{@submission.id}\"}" }}/
# / %br/
# / %br/
# / / The global progress bar
# / #progress.progress
# /   .progress-bar.progress-bar-success
# / / The container for the uploaded files
# / #files.files

# / / %span.btn.btn-success.fileinput-button
# / /   %i.glyphicon.glyphicon-plus
# / /   %span Add files...
# / /   / The file input field used as target for the file upload widget
# / /   %input#fileupload{multiple: true, name: "files[]", type: "file", data: { url: "//#{h request.host_with_port}/portal/funding_opportunities/attachments", 'form-data' => "{\"objects_name\": \"nucats_submission\", \"objects_id\": \"#{@submission.id}\"}" }}/
# / / %br/
# / / %br/
# / / / The global progress bar
# / / #progress.progress
# / /   .progress-bar.progress-bar-success
# / / / The container for the uploaded files
# / / #files.files