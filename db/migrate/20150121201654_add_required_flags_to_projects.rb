class AddRequiredFlagsToProjects < ActiveRecord::Migration
  def change
    add_column :nucats_projects, :biosketch_required, :boolean, default: true
    add_column :nucats_projects, :application_required, :boolean, default: true
    add_column :nucats_projects, :budget_required, :boolean, default: true
    add_column :nucats_projects, :other_support_required, :boolean, default: true
    add_column :nucats_projects, :document1_required, :boolean, default: true
    add_column :nucats_projects, :document2_required, :boolean, default: true
    add_column :nucats_projects, :document3_required, :boolean, default: true
    add_column :nucats_projects, :document4_required, :boolean, default: true
    add_column :nucats_projects, :supplemental_document_required, :boolean, default: false
  end
end
