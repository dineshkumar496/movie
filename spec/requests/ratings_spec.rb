# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Ratings', type: :request do
  let!(:user) { User.create!(email: 'aaa@gmail.com', password: '123456', admin: false) }
  let!(:user1) { User.create!(email: 'bbb@gmail.com', password: '123456', admin: false) }
  let!(:movie) { Movie.create!(name: 'asbdfdd', release_date: Date.today) }

  before do
    login_as(user, scope: :user)
  end

  describe 'GET /ratings/new' do
    context 'when user is authenticated' do
      it 'returns a success response' do
        get new_movie_rating_path(movie)
        expect(response).to be_successful
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to sign in page' do
        logout
        get new_movie_rating_path(movie)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST /movies' do
    context 'when authenticated' do
      context 'with valid params ' do
        it 'redirects to the created movie' do
          post movie_rating_path(movie), params: { rating: attributes_for(:rating, user:, star: 5) }
          expect(response).to be_successful
        end
      end

      context 'with invalid params' do
        it 'returns error' do
          post movie_rating_path(movie), params: { rating: attributes_for(:rating, user:, star: 5) }
          expect(response).to be_successful
        end
      end
    end
  end
end
