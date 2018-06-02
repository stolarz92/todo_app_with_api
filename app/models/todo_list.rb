class TodoList < ApplicationRecord
  belongs_to :user
  has_many :list_items, dependent: :destroy

  validates :name, presence: true
  validates :user, presence: true
end
