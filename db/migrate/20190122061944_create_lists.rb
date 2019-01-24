class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.string :title, presence: true
      t.bigint :owner_id

      t.timestamps
    end
  end
end
