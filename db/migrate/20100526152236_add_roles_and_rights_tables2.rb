class AddRolesAndRightsTables2 < ActiveRecord::Migration
  def self.up
    create_table :nucats_roles do |t|
      t.column :name, :string
      t.timestamps
    end
    
    create_table :nucats_rights do |t|
      t.column :name, :string 
      t.column :controller, :string 
      t.column :action, :string
      t.timestamps
    end
     
    create_table :nucats_roles_users  do |t| 
      t.column :role_id, :integer 
      t.column :user_id, :integer
      t.column :program_id, :integer
      t.timestamps
      t.integer   :created_id  
       t.string    :created_ip
       t.integer   :updated_id  
       t.string    :updated_ip
       t.timestamp :deleted_at
       t.integer   :deleted_id  
       t.string    :deleted_ip
    end  

    create_table :nucats_rights_roles, :id => false do |t| 
      t.column :right_id, :integer 
      t.column :role_id, :integer
      t.timestamps
    end
    
    Right.create :name => "List Reviewer", :controller=> 'reviewer', :action => 'index'
    Right.create :name => "View Reviewer", :controller=> 'reviewer', :action => 'view'
    Right.create :name => "Add Reviewer", :controller=> 'reviewer', :action => 'create'
    Right.create :name => "Edit Reviewer", :controller=> 'reviewer', :action => 'update'
    Right.create :name => "Remove Reviewer", :controller=> 'reviewer', :action => 'destroy'
    Right.create :name => "Admin", :controller=> 'admin'
#    Role.create  :name => "Reviewer Admin"
    Role.create  :name => "Admin"
    Role.create  :name => "Full Read-only Access"
#    the_role = Role.find_by_name("Reviewer Admin")
#    the_rights = Right.find(:all, :conditions => ['lower(name) like  :role_name', {:role_name => '%reviewer%'} ] )
#    the_rights.each do |the_right|
#      the_role.rights << the_right
#    end
    # user = User.find_by_username("wakibbe")
#    user.roles << the_role if ! user.blank? and 
    # the_role = Role.find_by_name("Admin")
    # user.roles << the_role if ! user.blank? && !the_role.blank?
    # the_role = Role.find_by_name("Full Read-only Access")
    # user.roles << the_role if ! user.blank? && !the_role.blank?
  end
  
  def self.down
    drop_table :nucats_roles_users 
    drop_table :nucats_rights_roles
    drop_table :nucats_roles 
    drop_table :nucats_rights 
  end
end
