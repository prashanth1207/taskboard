class List < ApplicationRecord
  has_many :cards
  has_many :members
  belongs_to :owner
end
