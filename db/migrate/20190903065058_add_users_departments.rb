class AddUsersDepartments < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :department
  end
end
