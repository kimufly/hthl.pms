class User < ApplicationRecord
  acts_as_paranoid
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :confirmable, :recoverable, :rememberable,
      :validatable, :timeoutable, :trackable

  enum sex: %i[unknown male femininity]

  belongs_to :role
  belongs_to :department
  has_many :projects
  delegate :computed_permissions, to: :role
  scope :up_password, -> { where(email: email, password: password) }

  ACCESSIBLE_ATTRS = %i[name email role_id sex phone_number status password locked_at explain password password_confirmation current_password]
end
