class CreateFileDocuments < ActiveRecord::Migration
  def self.up
    create_table :nucats_file_documents do |t|
      t.integer  :created_id
      t.string   :created_ip
      t.integer  :updated_id
      t.string   :updated_ip

      t.string :file_file_name
      t.string :file_content_type
      t.integer :file_file_size
      t.datetime :file_updated_at
      t.datetime :last_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :nucats_file_documents
  end
end
