class ProjectUser < ApplicationRecord 
    enum user_type: %i[project tech_user]
    belongs_to :project
    belongs_to :user
    accepts_nested_attributes_for :user
end
