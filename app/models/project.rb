class Project < ApplicationRecord
  enum genre: %i[pre-sale after-sale]
  enum status: %i[approving correction doing done close]

  belongs_to :user
  belongs_to :customer
end
