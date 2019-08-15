class Project < ApplicationRecord
  enum genre: %i[pre-sale after-sale]
  enum status: %i[approving correction doing done close]
end
