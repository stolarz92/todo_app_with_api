class ListItem < ApplicationRecord
  belongs_to :todo_list

  validates :name, presence: true

  scope :completed, -> { where.not(completed: nil) }
  scope :not_completed, -> { where(completed: nil) }

  def toggle_complete
    if completed?
      update_attribute(:completed, nil)
    else
      update_attribute(:completed, Time.now)
    end
  end

  def completed?
    !completed.blank?
  end
end
