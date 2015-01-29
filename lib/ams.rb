class Ams

  include HTTParty

  attr_accessor :config

  def get(revision_id)
    response = JSON.parse( post('getFileRevisionByID', revision_id) )
  end

  def create(file_name, file)
    response = JSON.parse( post('save', file) )
  end

  def post(method, file_object)
    ams_config = self.config
    if method == 'save'
      self.class.post(ams_config[:url],
        :body =>  {
          "login_key" => ams_config[:login],
          "transaction_key" => ams_config[:transaction],
          "user_id" => "136",
          "method" => method,
          "file" => Base64.encode64(file_object)
      })
    else
      self.class.post(ams_config[:url],
        :body =>  {
          "login_key" => ams_config[:login],
          "transaction_key" => ams_config[:transaction],
          "user_id" => "136",
          "method" => method,
          "revision_id" => file_object
      })
    end
  end

end