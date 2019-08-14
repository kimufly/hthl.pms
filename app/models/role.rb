# frozen_string_literal: true

class Role < RoleCore::Role
  has_many :users
end
