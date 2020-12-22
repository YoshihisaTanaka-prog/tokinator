class AddImageToRoutes < ActiveRecord::Migration[6.0]
  def change
    add_column :routes, :image, :string
  end
end
