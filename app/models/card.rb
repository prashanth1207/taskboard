class Card < ApplicationRecord
  validates :title, :description, presence: true

  belongs_to :list
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
end
