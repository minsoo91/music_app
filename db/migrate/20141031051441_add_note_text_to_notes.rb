class AddNoteTextToNotes < ActiveRecord::Migration
  def change
  	add_column :notes, :note_text, :text
  end
end
