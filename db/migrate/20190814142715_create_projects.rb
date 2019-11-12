class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name, null: false, default: "", comment: "项目名称"
      t.text :support_details, null: false, default: "", comment: "支持细节/内容"
      t.datetime :expected_at, comment: "期望日期"
      t.integer :genre, null: false, default: 0, comment: "类型"
      t.integer :auditor, comment: "审核人"
      t.integer :tech_auditor, comment: "技术审核人"
      t.text :remake, comment: "备注"
      t.float :time_limit, null: false, default: 0.0, comment: "工期"
      t.integer :status, null: false, default: 0, comment: "状态"
      t.timestamps
    end
    add_reference :projects, :user, foreign_key: true, comment: "项目归属人/项目经理"
    add_reference :projects, :customer, foreign_key: true, comment: "客户公司名"
    create_join_table :projects, :customer_contacts
    add_index :customer_contacts_projects, [:project_id, :customer_contact_id], unique: true, name: "unique_relationship"
  end
end
