class CreateLogs < ActiveRecord::Migration
  def self.up
    create_table :nucats_logs do |t|
      t.string :activity
      t.integer :user_id
      t.integer :program_id
      t.integer :project_id
      t.string :controller_name
      t.string :action_name
      t.text   :params
      t.string :created_ip

      t.timestamps
    end
  end

  def self.down
    drop_table :nucats_logs
  end
end
