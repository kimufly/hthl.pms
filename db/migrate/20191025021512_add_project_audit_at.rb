class AddProjectAuditAt < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :doing_at, :datetime
  end
end
