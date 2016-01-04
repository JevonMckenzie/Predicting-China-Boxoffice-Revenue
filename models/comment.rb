require 'virtus';

class Comment
  include Virtus.model

  attribute :rating, String
  attribute :date, String
  # attribute :user_id, String
  attribute :movie_title, String
  attribute :comment_title, String
  attribute :comment, String
end
