class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :status, presence: true, inclusion: { in: %w[pending in_progress completed] }
  validate :due_date_cannot_be_in_the_past, if: -> { due_date.present? && due_date_changed? }

  scope :pending, -> { where(status: 'pending') }
  scope :in_progress, -> { where(status: 'in_progress') }
  scope :completed, -> { where(status: 'completed') }
  scope :overdue, -> { where('due_date < ? AND status != ?', Time.current, 'completed') }
  scope :upcoming, -> { where('due_date > ?', Time.current) }

  def due_date_cannot_be_in_the_past
    if due_date.present? && due_date < Date.current
      errors.add(:due_date, "can't be in the past")
    end
  end
  
end
