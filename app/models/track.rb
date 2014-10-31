class Track < ActiveRecord::Base
	validates :name, :album_id, :lyrics, presence: true
	validates :edition, inclusion: { in: %w(Regular Bonus)}

	belongs_to(
		:album,
		class_name: "Album",
		foreign_key: :album_id,
		primary_key: :id
	)

	has_many(
		:notes,
		class_name: "Note",
		foreign_key: :track_id,
		primary_key: :id
	)
end
