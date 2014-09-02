# encoding: UTF-8
#
# Migration to add support for an optional supplemental document
class AddSupplementalDocumentSupport < ActiveRecord::Migration
  def change
    add_column :nucats_projects, :supplemental_document_name, :string, default: 'Supplemental Document (Optional)'
    add_column :nucats_projects, :supplemental_document_descr, :string, default: 'Please upload any supplemental information here. (Optional)'
    add_column :nucats_submissions, :supplemental_document_id, :integer
  end
end
