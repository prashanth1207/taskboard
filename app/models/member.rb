class Member < User
  has_many :lists, through: :user_lists
end