class CreateCustomerContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :customer_contacts do |t|
      t.string :name, null: false, default: ''
      t.string :telephone, null: false, default: ''
      t.string :phone_number
      t.string :other_phone
      t.string :email, null: false, default: ''
      t.string :address, null: false, default: ''
      t.string :position, null: false, default: ''
      t.timestamps
    end
    add_reference :customer_contacts, :customer, foreign_key: true
  end
end
