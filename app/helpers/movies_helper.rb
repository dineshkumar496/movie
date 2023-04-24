# frozen_string_literal: true

module MoviesHelper
  def ratings_method
    default_ratings = Hash[(1..5).reverse_each.map { |n| [n, 0] }]
    @ratings = default_ratings.merge @movie.ratings.group(:star).count
  end
end
