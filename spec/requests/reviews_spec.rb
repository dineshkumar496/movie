# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reviews', type: :request do
  before do
    login_as(user, scope: :user)
  end

  describe 'get /movie/review' do
    context 'when user is authenticated' do
      it 'returns a success response' do
        get new_movie_review_path(movie)
        expect(response).to be_successful
      end
    end
    context 'when user is not authenticated' do
      it 'returns a success response' do
        get new_movie_review_path(movie)
        expect(response).to_not be_successful
      end
    end
  end
end
