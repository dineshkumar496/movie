# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :movie, counter_cache: 'review_count'
  belongs_to :user

  # validations
  validates :body, presence: true
end
