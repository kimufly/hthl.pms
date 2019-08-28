class Customer < ApplicationRecord
  has_many :customer_contacts
  has_many :projects
end
