
require 'open-uri'
require 'nokogiri'
require 'xpath'

base_url = 'https://tw.movies.yahoo.com/movieinfo_main.html/'

record_hash = Hash.new { |hash, key| hash[key] = [] }

movies_id = *(5710..5720)
movies_id.each do |id|
  begin
    url = base_url + "id=#{id}"
    puts "movie id:::: .....#{id}"

    document = Nokogiri::HTML(open(url))
    movie = document.xpath("//div[@class='text bulletin']")
    title = movie.xpath("//h5").first.text
    date = movie.xpath("//p/span[@class='dta']")[0].text
    type = movie.xpath("//p/span[@class='dta']")[1].text
    duration = movie.xpath("//p/span[@class='dta']")[2].text
    director = movie.xpath("//p/span[@class='dta']")[3].text
    actors = movie.xpath("//p/span[@class='dta']")[4].text
    issuingcompany = movie.xpath("//p/span[@class='dta']")[5].text
    officialwebsite = movie.xpath("//p/span[@class='dta']")[6].text
    expectedratings = movie.xpath("//div[@class='vote clearfix']")[0].text


    # puts 'Title: ' << title
    # puts 'Release Date: ' << date
    # puts 'Type: ' << type
    # puts 'Duration: ' << duration
    # puts 'Director: ' << director
    # puts 'Actors: ' << actors
    # puts 'Issuing Company: ' << issuingcompany
    # puts 'Official Website:' << officialwebsite
    # puts "\n", "\n"

    record_hash["Title"] << "#{title}"
    record_hash["Release Date"] << "#{date}"
    record_hash["Type"] << "#{type}"
    record_hash["Duration"] << "#{duration}"
    record_hash["Director"] << "#{director}"
    record_hash["Actors"] << "#{actors}"
    record_hash["Issuing Company"] << "#{issuingcompany}"
    record_hash["Official Website"] << "#{officialwebsite}"


  rescue Exception => e
    puts "\n\n\nmovie with id#{id} NOT FOUND\n\n"
end

end
print record_hash
