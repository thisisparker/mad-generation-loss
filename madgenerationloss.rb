#!/usr/bin/ruby

tracklength = `mp3info -p %S ginsberg-howl.mp3`.to_i
splittimes = []

# Sets the times at which mp3splt will split the mp3.

i=0
while i < tracklength
	iminutes = i/60
	iseconds = i%60
	splittimes.push "#{sprintf '%02d', iminutes}.#{sprintf '%02d', iseconds}"
	i += 1
end
splittimes.push "EOF"

# Here's the split.

`mp3splt -d out/ ginsberg-howl.mp3 #{splittimes.join " "}`

# Creates an array of the mp3s that mp3splt just made

filearray = Dir.glob("out/*.mp3")

# Goes through each of the files in the array transcoding as many times as its index.

filearray.each_with_index do
	|entry, index|
	puts "processing #{entry}"
	`mv #{entry} temp.mp3`
	index.times do
		`lame --silent -b 64 temp.mp3 temp_processed.mp3 2> /dev/null` #LAME sometimes throws errors that can't be silenced about how hip can't step back certain values. This shuts that up.
		`rm temp.mp3`
		`mv temp_processed.mp3 temp.mp3`
	end
	multiplier = `sox temp.mp3 -n stat -v 2>&1`.to_i
	if multiplier != 0
		`sox -v #{multiplier} temp.mp3 #{entry}`
	end
	`rm temp.mp3`
end

# Wraps the mp3 files back together.

`mp3wrap madgenerationloss.mp3 out/*.mp3`