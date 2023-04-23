# frozen_string_literal: true

class Rating < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  # callbacks for updating the average rating of the movie
  after_commit :update_average_rating, on: %i[create update]

  # validations
  validates :star, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 6 }
  validates :movie_id, uniqueness: { scope: :user_id, message: 'You can only rate a movie once.' }

  private

  # method for update average rating
  def update_average_rating
    movie = Movie.find(movie_id)
    movie.average_rating = movie.ratings.average(:star)
    movie.save
  end
end
