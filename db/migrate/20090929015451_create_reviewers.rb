class CreateReviewers < ActiveRecord::Migration
  def self.up
    create_table :nucats_reviewers do |t|
      t.integer :program_id
      t.integer :user_id

      t.integer   :created_id  
      t.string    :created_ip
      t.integer   :updated_id  
      t.string    :updated_ip
      t.timestamp :deleted_at
      t.integer   :deleted_id  
      t.string    :deleted_ip

      t.timestamps
    end
  end

  def self.down
    drop_table :nucats_reviewers
  end
end
