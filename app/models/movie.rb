# frozen_string_literal: true

class Movie < ApplicationRecord
  self.per_page = 15

  has_many :ratings, dependent: :destroy
  has_many :reviews, dependent: :destroy

  # validations
  validates :name, length: { in: 1..50 }
  validates :release_date, presence: true

  # scopes
  # changing default scope to return in the order of max rated movie first
  default_scope { order(average_rating: :desc) }

  # Scope for filtering movies using release date
  scope :filter_by_date, lambda { |given_date|
    where(release_date: given_date)
  }

  def self.ransackable_attributes(_auth_object = nil)
    ['name']
  end
end
