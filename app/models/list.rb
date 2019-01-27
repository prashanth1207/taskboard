class List < ApplicationRecord

  validates :title, :owner_id, presence: true

  has_many :cards, dependent: :destroy
  has_many :user_lists, dependent: :destroy
  has_many :members, through: :user_lists
  belongs_to :owner, class_name: 'Admin', foreign_key: 'owner_id', optional: true

  def assign_members(member_ids=[])
    member_ids.delete(owner_id)
    self.members << Member.find(member_ids)
  end

  def unassign_members(member_ids=[])
    self.user_lists.where(user_id: [member_ids]).map(&:destroy)
    self.reload.members
  end

  def member?(user_id)
    self.members.where(id: user_id).exists?
  end

  def owner?(user_id)
    self.owner.id == user_id
  end

  def showable?(user_id)
    owner?(user_id) || member?(user_id)
  end
end
