class Admin < ActiveRecord::Base
  self.table_name = 'nucats_admins'
  # each admin is a user (but through a user_id) and belongs to a program
  belongs_to :program
  belongs_to :user

  attr_accessor :reviewer_list

end
