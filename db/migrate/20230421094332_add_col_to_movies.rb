class AddColToMovies < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :average_rating,  :float, precision: 1 , default: 0
    add_column :movies, :review_count, :integer ,default: 0
  end
end
