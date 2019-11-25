class Customer < ApplicationRecord
  has_many :customer_contacts, :dependent => :destroy
  has_many :projects
  validates :name, uniqueness: true
  accepts_nested_attributes_for :customer_contacts
end
