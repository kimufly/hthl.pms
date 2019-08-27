class User < ApplicationRecord
  acts_as_paranoid
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :confirmable, :recoverable, :rememberable,
      :validatable, :timeoutable, :trackable, :lockable

  enum sex: %i[unknown male femininity]

  belongs_to :role
  has_many :projects
  
  delegate :computed_permissions, to: :role
  scope :up_password, -> { where(email: email, password: password) }

end
