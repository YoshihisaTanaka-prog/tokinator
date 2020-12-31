class CreateSupportChats < ActiveRecord::Migration[6.0]
  def change
    create_table :support_chats do |t|
      
      t.integer :customer_id
      t.boolean :isFromI
      t.text    :text
      t.text    :url

      t.timestamps
    end
  end
end
