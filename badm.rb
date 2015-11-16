require 'open-uri'
require 'nokogiri'
require 'yaml'
require 'csv'
require_relative 'lib/scraper'

base_url = 'https://tw.movies.yahoo.com/movieinfo_main.html/'

records = []
movies_id = *(5710..5720)
movies_id.each do |id|
  begin
    url = base_url + "id=#{id}"
    document = Nokogiri::HTML(open(url))
    records.push(Scraper.call(document).to_hash)
  rescue
    puts "\n\nmovie with id#{id} NOT FOUND\n\n"
end
end

filename = 'results.csv'
# print records
header = records[0].keys
CSV.open(filename, 'w') do |csv|
  csv << header
  records.each do |record|
    csv << record.values
  end
end
