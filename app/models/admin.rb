class Admin < User
  has_many :created_lists, class_name: 'List', foreign_key: 'owner_id'
end