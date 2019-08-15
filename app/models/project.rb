class Project < ApplicationRecord
  enum genre: %i[pre-sale after-sale]

end
