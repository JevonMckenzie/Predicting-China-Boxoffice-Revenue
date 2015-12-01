require_relative '../lib/scraper'

movies_base_url = 'https://tw.movies.yahoo.com/movieinfo_main.html/'
comments_base_url= 'https://tw.movies.yahoo.com/movieinfo_review.html/' #id=4820&s=0&o=0&p=2

records = []
# movies_id = *(4085..6048)
movies_id = *(1..6048)
movies_id.each do |id|
  begin
    movies_url = movies_base_url + "id=#{id}"
    comments_url = comments_base_url + "id=#{id}&p=0"
    movie_document = Nokogiri::HTML(open(movies_url))
    comments_document = Nokogiri::HTML(open(comments_url))
    total_comments = comments_document.xpath("//div[@class='statistic']/em").first.text
    records.push(MovieScraper.call(movie_document, id, total_comments).to_hash)
  rescue Exception => e
    puts "\n\nmovie with id: #{id} NOT FOUND\n\n"
end
end

filename = 'movies.csv'
# print records
header = records[0].keys
CSV.open(filename, 'w', {col_sep: "\t", force_quotes: true}) do |csv|
  csv << header
  records.each do |record|
    csv << record.values
  end
end
