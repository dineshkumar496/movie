# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Movies', type: :request do
  let!(:user) { User.create!(email: 'aaa@gmail.com', password: '123456', admin: true) }
  let!(:user1) { User.create!(email: 'dinesh@gmail.com', password: '123456') }
  let!(:movie1) { Movie.create!(name: 'aaa', release_date: Date.yesterday) }
  let!(:movie2) { Movie.create!(name: 'bbb', release_date: Date.today) }
  let!(:movie3) { Movie.create!(name: 'ccc', release_date: Date.tomorrow) }

  describe 'when user is authenticated' do
    before do
      login_as(user, scope: :user)
    end

    context 'GET /movies' do
      it 'returns a success response' do
        get movies_path
        expect(response).to be_successful
      end

      it 'return a success with search results' do
        get movies_path, params: { q: 'aaa' }
        expect(response).to be_successful
        expect(response.body).to include('aaa')
      end

      it 'return a success with filtered results' do
        get movies_path, params: { release_date: Date.today }
        expect(response).to be_successful
        expect(response.body).to include('bbb')
      end
    end

    context 'Get /movies/:id' do
      it 'returns a success response' do
        get movie_path(movie1)
        expect(response).to be_successful
      end
    end

    context 'GET /movies/new' do
      it 'returns a success response with admin role' do
        get new_movie_path
        expect(response).to be_successful
      end

      it 'should not returns a success response without admin role' do
        logout
        login_as(user1, scope: :user1)
        get new_movie_path
        expect(response).to_not be_successful
      end
    end
  end

  describe 'when user is not authenticated' do
    context 'Get /movies' do
      it 'should not returns a success response' do
        get movies_path
        expect(response).to_not be_successful
      end
    end

    context 'Get /movies/:id' do
      it 'should not returns a success response' do
        get movie_path(movie1)
        expect(response).to_not be_successful
      end
    end

    context 'Get /movies/new' do
      it 'should not returns a success' do
        get new_movie_path
        expect(response).to_not be_successful
      end
    end
  end
end
