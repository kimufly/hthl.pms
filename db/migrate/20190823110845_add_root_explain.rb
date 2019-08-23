class AddRootExplain < ActiveRecord::Migration[5.2]
  def change
    add_column :roles, :explain, :string
    
  end
end
