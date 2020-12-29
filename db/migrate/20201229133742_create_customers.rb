class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      i.string :user_attribute

      t.timestamps
    end
  end
end
