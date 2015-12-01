require 'xpath'
require_relative '../models/comment'

module CommentsScraper
  def self.call(document)
    movie_title = document.xpath("//div[@class='text bulletin']/h4/a").text

    comments = document.xpath("//div[@class='bd-container']/div[contains(@class,'row')]")
    records = []
    i = 0
    comments.map do |comment|
      result = Comment.new();
      result.movie_title = movie_title
      result.rating = comment.xpath("//div[@class='rate']/img/@src")[i].text
      result.date = comment.xpath("//div[@class='date']")[i].text
      result.comment_title = comment.xpath("//div[@class='text']/h4")[i].text
      result.comment = comment.xpath("//div[@class='text']/p")[i].text
      records.push(result.to_hash)
      i = i+1
    end
    records
  end
end
