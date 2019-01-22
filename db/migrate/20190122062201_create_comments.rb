class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content
      t.belongs_to :user
      t.integer :commentable_id
      t.string  :commentable_type

      t.timestamps
    end
  end
end
