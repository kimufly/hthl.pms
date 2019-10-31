class CustomerContact < ApplicationRecord
  belongs_to :customer
  has_and_belongs_to_many :projects
 
  scope :find_by_customer_id, -> (customer_id) { where(customer_id: customer_id) }
end
