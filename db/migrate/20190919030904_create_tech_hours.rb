class CreateTechHours < ActiveRecord::Migration[5.2]
  def change
    create_table :tech_hours do |t|
      t.integer :user_id, comment: "用户ID"
      t.integer :project_id, comment: "项目ID"
      t.float :time_limit, comment: "工时记录(天)"
      t.string :describe, comment: "工作内容描述"
      t.datetime :start_at, comment: "开始时间"

      t.timestamps
    end
  end
end
