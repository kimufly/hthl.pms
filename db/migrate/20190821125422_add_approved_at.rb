class AddApprovedAt < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :number, :string
    add_column :projects, :approved_at, :datetime
    add_column :projects, :done_at, :datetime
    add_column :projects, :deleted_at, :datetime
  end
end
