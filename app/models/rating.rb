class Rating < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  #callbacks for updating the average rating of the movie
  after_create :update_average_rating
  after_update :update_average_rating

  #validations
  validates :movie_id, uniqueness: { scope: :user_id, message: "You can only rate a movie once." }

  private
  #method for update average rating
  def update_average_rating
    movie=Movie.find(movie_id)
    movie.average_rating=movie.ratings.average(:star)
    movie.save
  end
end
