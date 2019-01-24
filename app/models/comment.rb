class Comment < ApplicationRecord
  validates :content, :commentable_id, :commentable_type, presence: true

  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :replies, as: :commentable, class_name: 'Comment', dependent: :destroy

  def commented_card
    source = self.commentable
    while source.class != Card
      source = source.commentable
    end
    source
  end
end
