require 'virtus';

class Movie
  include Virtus.model

  attribute :title, String
  attribute :date, String
  attribute :type, String
  attribute :duration, String
  attribute :director, String
  attribute :actors, String
  attribute :issuing_company, String
  attribute :official_website, String
  attribute :expected_rating, String
end
