class CreateProjectUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :project_users do |t|
      t.integer :user_type, null: false, default: 0, comment: "类型"
      t.bigint :project_id, comment: "项目ID"
      t.bigint :user_id, comment: "用户ID"
      t.timestamps
    end
  end
end
