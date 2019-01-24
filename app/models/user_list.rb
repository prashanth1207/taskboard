class UserList < ApplicationRecord
  self.table_name = 'users_lists'

  validates :user_id, uniqueness: { scope: :list_id, message: "member already added to the list"}

  belongs_to :member, foreign_key: :user_id, optional: true
  belongs_to :list, optional: true
end