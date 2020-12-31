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

      t.integer       :total_accessed, null: false, default: 0
      t.time          :total_accessed_start

      t.integer       :j1_accessed, null: false, default: 0
      t.integer       :j1_score,    null: false, default: 0
      t.time          :j1_start

      t.integer       :j2_accessed, null: false, default: 0
      t.integer       :j2_score,    null: false, default: 0
      t.time          :j2_start

      t.integer       :j3_accessed, null: false, default: 0
      t.integer       :j3_score,    null: false, default: 0
      t.time          :j3_start


      t.integer       :h1s_accessed, null: false, default: 0
      t.integer       :h1s_score,    null: false, default: 0
      t.time          :h1s_start

      t.integer       :h2s_accessed, null: false, default: 0
      t.integer       :h2s_score,    null: false, default: 0
      t.time          :h2s_start

      t.integer       :h3s_accessed, null: false, default: 0
      t.integer       :h3s_score,    null: false, default: 0
      t.time          :h3s_start


      t.integer       :h1h_accessed, null: false, default: 0
      t.integer       :h1h_score,    null: false, default: 0
      t.time          :h1h_start

      t.integer       :h2h_accessed, null: false, default: 0
      t.integer       :h2h_score,    null: false, default: 0
      t.time          :h2h_start

      t.integer       :h3h_accessed, null: false, default: 0
      t.integer       :h3h_score,    null: false, default: 0
      t.time          :h3h_start


      t.integer       :h1n_accessed, null: false, default: 0
      t.integer       :h1n_score,    null: false, default: 0
      t.time          :h1n_start

      t.integer       :h2n_accessed, null: false, default: 0
      t.integer       :h2n_score,    null: false, default: 0
      t.time          :h2n_start

      t.integer       :h3n_accessed, null: false, default: 0
      t.integer       :h3n_score,    null: false, default: 0
      t.time          :h3n_start

      t.integer       :constructing, null: false, default: 0
      t.time          :constructing_accessed_at

      t.timestamps
    end
  end
end
