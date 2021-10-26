class CreateTokinatorColumns < ActiveRecord::Migration[6.1]
  def change
    create_table :tokinator_columns do |t|
      t.string :colunm_name

      t.timestamps
    end
  end
end
