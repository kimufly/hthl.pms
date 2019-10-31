class CreateAudits < ActiveRecord::Migration[5.2]
  def change
    create_table :audits do |t|
      t.integer :user_id
      t.integer :project

      t.timestamps
    end
  end
end
