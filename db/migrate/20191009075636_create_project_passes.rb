class CreateProjectPasses < ActiveRecord::Migration[5.2]
  def change
    create_table :project_passes do |t|
      t.string :name, null: false, default: "", comment: "文档名称"
      t.integer :project_id, null: false, comment: "项目ID"
      t.integer :user_id, null: false, comment: "用户ID"
      t.datetime :created_at, null: false
      t.integer :pass, comment: "通过/不通过"
      t.text :remark, comment: "备注"

      t.timestamps
    end
    add_reference :projects, :project_pass, foreign_key: true, comment: "项目结束文档审核"
  end
end
