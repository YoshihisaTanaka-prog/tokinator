class CreateUCounts < ActiveRecord::Migration[6.0]
  def change
    create_table :u_counts do |t|

      t.integer   :user_id
      t.integer   :count, null: false, default: 0
      t.string    :title

      t.timestamps
    end
  end
end
