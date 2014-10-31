class AddEditionToTracks < ActiveRecord::Migration
  def change
  	add_column :tracks, :edition, :string
  end
end
