#!/usr/bin/env ruby

list = Dir['_posts/*.adoc']
list.each do |file|
	readfile = File.open(file, 'r', :encoding => "UTF-8")
	contentsArray = readfile.readlines
	readfile.close
	if contentsArray[0] == "---\n"
		puts "[*] Processing #{file}"
		counter = 0
		tags = []
		title = ''
		(1..contentsArray.size).each do |line|
			if contentsArray[line] == "---\n"
				counter = line
				break
			end
			if contentsArray[line] =~ /^-/
				tags << contentsArray[line].split("- ")[1].strip
			end
			if contentsArray[line] =~ /^title: /
				title = contentsArray[line].split('title: ')[1].strip
			end
		end
		taglist = tags.join(', ')
		writefile = File.open("other_posts/#{file}",'w')
		writefile.write "= #{title}\n"
		writefile.write ":hp-tags: #{taglist}\n"
		((counter+1)..contentsArray.size).each do |x|
			writefile.write "#{contentsArray[x]}"
		end
	end
end