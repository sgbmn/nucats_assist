# encoding: UTF-8
# == Schema Information
# Schema version: 20130511121216
#
# Table name: key_personnel
#
#  created_at    :datetime
#  email         :string(255)
#  first_name    :string(255)
#  id            :integer          not null, primary key
#  last_name     :string(255)
#  role          :string(255)
#  submission_id :integer
#  updated_at    :datetime
#  user_id       :integer
#  username      :string(255)
#

class KeyPerson < ActiveRecord::Base
  self.table_name = 'nucats_key_personnel'
  belongs_to :submission
  belongs_to :user
  accepts_nested_attributes_for :submission, :allow_destroy => true, :reject_if => :all_blank

  attr_accessible *column_names
  attr_accessible :user, :submission

  def self.quotes
    "\x91\x92\x93\x94".unpack("Z*")
  end
  def self.right_quote
    "\x92".unpack("Z*")[0]
  end

  def uploaded_biosketch=(data_field)
    # this is simply a placeholder for updating the key_person's biosketch.
    self.user.uploaded_biosketch = data_field
  end
  def name
    [first_name, last_name].join(' ').gsub(/\'/, KeyPerson.right_quote).strip
  end
  def sort_name
    [last_name, first_name].join(', ').gsub(/\'/, KeyPerson.right_quote).strip
  end

end
