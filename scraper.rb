require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'mechanize'

puts "Paste Link:"
link       = gets.chomp.to_s
picArray   = []
counter    = 0
picsAmount = 0

agent = Mechanize.new
doc   = Nokogiri::HTML(open(link))
posts = doc.css('div.postContainer')

posts.each do |each|
  begin
    pic = each.at_css('div.file').at_css('div.fileText').at_css('a')['href'].to_s.gsub(/\/\//,'http://')
    picArray << pic
    picsAmount += 1
    counter += 1
    puts "Found Pic From Post #" + counter.to_s
  rescue
    counter += 1
  end
end

picArray.each do |link|
  agent.get(link.to_s).save
end
puts "Total: " + picsAmount.to_s