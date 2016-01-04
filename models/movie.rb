require 'virtus';

class Movie
  include Virtus.model

  attribute :movie_id, String
  attribute :total_comments, String
  attribute :title, String
  attribute :date, String
  attribute :type, String
  attribute :duration, String
  attribute :director, String
  attribute :actors, String
  attribute :issuing_company, String
  attribute :official_website, String
  attribute :expected_rating, String
  attribute :num_exp_votes, String
  attribute :actual_rating, String
  attribute :num_actual_votes, String
  #attribute :num_trailer, String
end
