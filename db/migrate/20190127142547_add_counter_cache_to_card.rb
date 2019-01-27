class AddCounterCacheToCard < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :comments_count, :integer, default: 0, null: false
  end
end
