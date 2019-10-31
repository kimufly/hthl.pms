class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.string :name, null: false, default: "", comment: "文档名称"
      t.integer :document_type, null: false, default: 0, comment: "类型"
      t.integer :project_id, null: false, comment: "项目ID"
      t.integer :user_id, null: false, comment: "用户ID"
      t.datetime :created_at

      t.timestamps
    end
  end
end
