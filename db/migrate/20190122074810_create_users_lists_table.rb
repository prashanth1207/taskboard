class CreateUsersListsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users_lists do |t|
      t.belongs_to :user
      t.belongs_to :list
    end
  end
end
