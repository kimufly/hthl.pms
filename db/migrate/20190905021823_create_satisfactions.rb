class CreateSatisfactions < ActiveRecord::Migration[5.2]
  def change
    create_table :satisfactions do |t|
      t.bigint :project_id, comment: "项目id"
      t.bigint :customer_id, comment: "联系人id"
      t.string :case_num, comment: "CASE号"
      t.integer :service_type, null: false, default: 0, comment: "服务类型"
      t.datetime :start_at, comment: "服务开始时间"
      t.datetime :use_at, comment: "服务使用时间"
      t.integer :true_at, comment: "实际使用时间(小时)"
      t.integer :service_quality, null: false, default: 0, comment: "服务质量"
      t.integer :complaints_hotline, null: false, default: 0, comment: "投诉电话"
      t.integer :service_engineer, null: false, default: 0, comment: "服务的工程师"
      t.integer :engineer, null: false, default: 0, comment: "工程师"
      t.string :engineer_satisfaction, comment: "工程师满意方面"
      t.integer :technical_support, null: false, default: 0, comment: "技术支持"
      t.integer :sales_service, null: false, default: 0, comment: "售后服务"
      t.integer :customer_eturn_visit, null: false, default: 0, comment: "客户回访"
      t.string :other_opinions, null: false, default: 0, comment: "其它建议"
      t.timestamps
    end
  end
end
