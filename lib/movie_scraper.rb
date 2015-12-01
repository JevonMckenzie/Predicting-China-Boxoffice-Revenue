require 'xpath'
require_relative '../models/movie'

module MovieScraper
  def self.call(document, movie_id, total_comments)
    result = Movie.new();
    result.movie_id = movie_id
    result.total_comments = total_comments
    movie = document.xpath("//div[@class='text bulletin']")
    exp_ratings = document.xpath("//div[@class='vote clearfix']")
    act_ratings = document.xpath("//div[@class='sum']")
    #number_trailer = document.xpath("//div[@class='statistic']")
    result.title = movie.xpath("//h5").first.text
    result.expected_rating = exp_ratings.xpath("//strong").first.text
    result.num_exp_votes = exp_ratings.xpath("//span//q").first.text
    result.actual_rating = act_ratings.xpath("//p//em").first.text
    result.num_actual_votes = act_ratings.xpath("//span//q")[1].text
    #result.num_trailer = number_trailer.xpath("//em").first.text

    keys = ['result.date', 'result.type', 'result.duration', 'result.director',
      'result.actors', 'result.issuing_company', 'result.official_website']
    (0..6).each do |index|
      value = movie.xpath("//p/span[@class='dta']")[index].text
      eval("#{keys[index]}=value")
    end
    result
  end
end
