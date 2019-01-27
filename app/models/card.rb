class Card < ApplicationRecord
  validates :title, :description, presence: true
  validates :comments_count, numericality: {greater_than_or_equal_to: 0}

  belongs_to :list
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  def owner?(user_id)
    self.user_id == user_id
  end
end
