class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :title
      t.text :description
      t.belongs_to :user
      t.belongs_to :list

      t.timestamps
    end
  end
end
