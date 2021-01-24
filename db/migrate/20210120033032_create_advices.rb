class CreateAdvices < ActiveRecord::Migration[6.0]
  def change
    create_table :advices do |t|

      t.timestamps
    end
  end
end
