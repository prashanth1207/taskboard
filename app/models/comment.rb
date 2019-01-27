class Comment < ApplicationRecord
  validates :content, :commentable_id, :commentable_type, presence: true

  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :replies, as: :commentable, class_name: 'Comment', dependent: :destroy

  after_create :increment_comments_count

  after_destroy :decrement_comments_count

  # method to increment the count of comments when a new comment is added to the card
  def increment_comments_count
    return unless commented_on_card?
    commentable.update(comments_count: commentable.comments_count + 1)
  end

  # method to decrement the count of comments when a new comment is removed from the card
  def decrement_comments_count
    return unless commented_on_card?
    commentable.update(comments_count: commentable.comments_count - 1)
  end

  def commented_on_card?
    commentable_type == 'Card'
  end

  def commented_card
    source = self.commentable
    while source.class != Card
      source = source.commentable
    end
    source
  end
end
