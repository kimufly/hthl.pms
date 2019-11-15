class User < ApplicationRecord
  validates :name, presence: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :phone_number, presence: true, length: { minimum: 11 }
  validates :email, presence: true, format: { with: /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/, message: "邮箱格式不正确，请从新输入" }
  acts_as_paranoid
  has_one_attached :picture
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable, :registerable
  devise :database_authenticatable, :confirmable, :recoverable, :rememberable,
      :validatable, :timeoutable, :trackable
  enum sex: %i[unknown male femininity]


  belongs_to :role
  belongs_to :department
  has_many :projects
  has_many :project_users
  has_many :tech_hours
  has_many :project_pass
  has_many :documents
  has_many :token
  delegate :computed_permissions, to: :role
  scope :up_password, -> { where(email: email, password: password) }
  accepts_nested_attributes_for :department
  ACCESSIBLE_ATTRS = %i[name email role_id sex phone_number status password locked_at explain password password_confirmation current_password department_id picture price]
end
