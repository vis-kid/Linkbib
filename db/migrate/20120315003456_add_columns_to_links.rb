class AddColumnsToLinks < ActiveRecord::Migration
  def change
    add_column :links, :title, :string

    add_column :links, :description, :string

  end
end
