class Card < ApplicationRecord
  belongs_to :list
  belongs_to :owner
  has_many :comments, as: :commentable
end
