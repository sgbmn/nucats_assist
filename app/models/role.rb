# == Schema Information
# Schema version: 20130511121216
#
# Table name: roles
#
#  created_at :datetime
#  id         :integer          not null, primary key
#  name       :string(255)
#  updated_at :datetime
#

class Role < ActiveRecord::Base
  has_many :roles_users
  has_many :users, :through => :roles_users
  has_and_belongs_to_many :rights
    
end
