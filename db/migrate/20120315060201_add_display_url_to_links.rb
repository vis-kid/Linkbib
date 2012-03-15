class AddDisplayUrlToLinks < ActiveRecord::Migration
  def change
    add_column :links, :display_url, :string

  end
end
