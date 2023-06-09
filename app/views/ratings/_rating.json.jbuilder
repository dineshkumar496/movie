# frozen_string_literal: true

json.extract! rating, :id, :star, :movie_id, :user_id, :created_at, :updated_at
json.url rating_url(rating, format: :json)
