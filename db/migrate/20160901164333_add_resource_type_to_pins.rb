class AddResourceTypeToPins < ActiveRecord::Migration[5.0]
  def change
    add_column :pins, :resource_type, :string
  end
end
