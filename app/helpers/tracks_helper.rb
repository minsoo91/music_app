module TracksHelper
	def ugly_lyrics(lyrics)
		lyrics = "#{lyrics}".html_safe
		lyrics = lyrics.split("\r\n")
		lyrics.map! do |line|
			"&#9835  " + line
		end
		"<pre>#{lyrics.join("\r\n")}</pre>".html_safe
	end
end
