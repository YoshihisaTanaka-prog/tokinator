class CreateRCounts < ActiveRecord::Migration[6.0]
  def change
    create_table :r_counts do |t|

      t.integer   :route_id
      t.integer   :count, null: false, default: 0
      t.string    :title

      t.timestamps null: false
    end
  end
end
