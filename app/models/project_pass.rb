class ProjectPass < ApplicationRecord
    enum pass: %i[done correction refuse]
    belongs_to :user
    belongs_to :project
end
