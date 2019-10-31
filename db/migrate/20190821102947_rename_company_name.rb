class RenameCompanyName < ActiveRecord::Migration[5.2]
  def change
    rename_column :customers, :company_name, :name
  end
end
