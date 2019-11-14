class AddProjectsProjectPass < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :project_pass, :integer
end
