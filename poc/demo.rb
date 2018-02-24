require 'cgi'
require 'nokogiri'

# Take a given string as a searchTerm
moviename = 'Горячие головы'
searchterm = CGI.escape("#{moviename} torrent")
url = "https://google.com/search?q=#{searchterm}"
pagesource = `lynx --source '#{url}'`
page = Nokogiri::HTML(pagesource)

links = page.css('a:not([class])')

selected = links.select { |link| link['href'].start_with?('/url?q=') }
selected = selected.map { |link| link['href'].gsub!('/url?q=', '') }

puts "There's #{selected.size} results: "
selected.each { |link| puts link }
puts "Report is over for #{selected.size} items"
