class AddStatusExplain < ActiveRecord::Migration[5.2]
  def change
    add_column :roles, :status, :string
  end
end
