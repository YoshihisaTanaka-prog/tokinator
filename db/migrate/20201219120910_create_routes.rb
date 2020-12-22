class CreateRoutes < ActiveRecord::Migration[6.0]
  def change
    create_table :routes do |t|

      t.string        :before_id
      t.string        :next_title_name
      t.string        :table_name
      t.string        :after_id
      t.text          :comment  , null: false, default: ""
      t.integer       :strength , null: false, default: 0
      t.integer       :group    , null: false, default: 0

      t.timestamps
    end
  end
end
