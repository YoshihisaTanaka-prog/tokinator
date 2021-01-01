class CreateSupportChats < ActiveRecord::Migration[6.0]
  def change
    create_table :support_chats do |t|
      
      t.integer :customer_id
      t.boolean :isFromCustomer
      t.text    :text
      t.text    :url, null: false, default: ''

      t.timestamps
    end
  end
end
