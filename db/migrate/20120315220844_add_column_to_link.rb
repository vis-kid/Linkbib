class AddColumnToLink < ActiveRecord::Migration
  def change
    add_column :links, :favicon_url, :string

  end
end
