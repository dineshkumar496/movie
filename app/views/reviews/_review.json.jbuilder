# frozen_string_literal: true

json.extract! review, :id, :body, :movie_id, :user_id, :created_at, :updated_at
json.url review_url(review, format: :json)
