require_relative '../lib/scraper'

base_url= 'https://tw.movies.yahoo.com/movieinfo_review.html/' #id=4820&s=0&o=0&p=2

records = []
movies_id = *(3080..3080)

movies_id.each do |movie_id|
  pages_url = base_url + "id=#{movie_id}&p=0"
  total_pages = 0
  total_comments = 0
  begin
    doc = Nokogiri::HTML(open(pages_url))
    total_comments = doc.xpath("//div[@class='statistic']/em").first.text
    total_pages = ((total_comments.to_f)/10).ceil
  rescue
    puts "\n\nmovie with id#{movie_id} NOT FOUND\n\n"
  end

  if total_comments.to_i > 1
    total_pages = (total_pages==1) ? 0 : total_pages
    pages_id = *(0..total_pages)
    pages_id.each do |page_id|
      url = base_url + "id=#{movie_id}&p=#{page_id}"
      begin
        document = Nokogiri::HTML(open(url))
        records.push(CommentsScraper.call(document))
      rescue Exception => e
        puts "\n\nmovie with id#{movie_id} NOT FOUND\n\n"
      end
    end
  end
end

filename = 'comments.csv'
header = records[0][0].keys
CSV.open(filename, 'w', {force_quotes: true, col_sep: "\t"}) do |csv|
  csv << header
  records.each do |page_of_records|
    page_of_records.each do |record|
      csv << record.values
    end
  end
end
