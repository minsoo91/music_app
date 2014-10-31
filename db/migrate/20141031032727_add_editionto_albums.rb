class AddEditiontoAlbums < ActiveRecord::Migration
  def change
  	add_column :albums, :edition, :string
  end
end
