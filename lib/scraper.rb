require 'xpath'
require_relative '../models/movie'

module Scraper
  @MOVIE_PATH = "//div[@class='text bulletin']"
  def self.call(document)
    result = Movie.new();
    movie = document.xpath("//div[@class='text bulletin']")
    result.title = movie.xpath("//h5").first.text

    keys = ['result.date', 'result.type', 'result.duration', 'result.director',
      'result.actors', 'result.issuing_company', 'result.official_website']
    (0..6).each do |index|
      value = movie.xpath("//p/span[@class='dta']")[index].text
      eval("#{keys[index]}=value")
    end
    result.expected_rating = movie.xpath("//div[@class='vote clearfix']")[0].text
    result
  end
end
