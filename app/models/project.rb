class Project < ApplicationRecord
  acts_as_paranoid
  enum genre: %i[pre-sale after-sale]
  enum status: %i[approving correction doing done close]

  belongs_to :user
  belongs_to :customer
  has_and_belongs_to_many :customer_contacts
  accepts_nested_attributes_for :customer
  

  scope :mine, -> (user_id) { where(user_id: user_id) }
  scope :approving, -> { where(status: [:approving, :correction]) }
  scope :closed, -> { where(status: :close) }

  after_create :generate_number
  before_save :update_done_at, :update_approved_at

  def update_done_at
    self.done_at = Time.zone.now if self.status == "done" and self.status_was != "done"
  end

  def update_approved_at
    self.approved_at = Time.zone.now if self.status == "doing" and self.status_was != "doing"
  end

  def generate_number
    number = "RS%05d" % self.id
    self.update(number: number)
  end

end
