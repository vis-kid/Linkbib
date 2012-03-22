class AddColumnToLinks < ActiveRecord::Migration
  def change
    add_column :links, :display_title, :string

  end
end
