class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string  :user_attribute

      t.integer :access_count, null: false, default: 0
      t.integer :score_count,  null: false, default: 0
      t.decimal :average_score
      t.time    :start

      t.timestamps
    end
  end
end
