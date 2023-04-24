# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Movies', type: :request do
  let!(:user) { User.create!(email: 'aaa@gmail.com', password: '123456', admin: false) }
  let!(:admin) { User.create!(email: 'dinesh@gmail.com', password: '123456', admin: true) }
  let!(:movie1) { Movie.create!(name: 'aaa', release_date: Date.yesterday) }
  let!(:movie2) { Movie.create!(name: 'bbb', release_date: Date.today) }
  let!(:movie3) { Movie.create!(name: 'ccc', release_date: Date.tomorrow) }

  describe "signed in as admin" do
    context 'GET /movies' do
      it 'returns a success response' do
        login_as(user, scope: :user)
        get movies_path
        expect(response).to be_successful
      end

      it 'return a success with search results' do
        login_as(user, scope: :user)
        get movies_path, params: { q: 'aaa' }
        expect(response).to be_successful
      end

      it 'return a success with filtered results' do
        login_as(user, scope: :user)
        get movies_path, params: { release_date: Date.today }
        expect(response).to be_successful
      end
    end

    describe 'GET /movies/:id' do
      it 'returns a success response' do
        login_as(user, scope: :user)
        get movie_path(movie1)
        expect(response).to be_successful
      end
    end

    describe 'GET /movies/new' do
      context 'when user is authorized as admin' do
        it 'returns a success response' do
          login_as(admin, scope: :admin)
          get new_movie_path
          expect(response).to be_successful
        end
      end

      context 'when user is authorized as normal user' do
        it 'returns a unsuccessful response ' do
          login_as(user, scope: :user)
          get new_movie_path
          expect(response).to_not be_successful
        end
      end

    end

    context 'when user is not authenticated' do
      it 'redirects to sign in page' do

        get new_movie_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST /movies' do
    context 'with admin access ' do

      context 'with valid params ' do
        it 'redirects to the created movie' do
          login_as(admin, scope: :admin)
          post movies_path, params: { movie: attributes_for(:movie, user:) }
          expect(response).to redirect_to(Movie.last)
        end
      end

      context 'with invalid params' do
        it 'renders the new template' do
          login_as(admin, scope: :admin)
          post movies_path, params: { movie: attributes_for(:movie, name: nil, user:) }
          expect(response).to render_template(:new)
        end
      end
    end
    context 'without admin access' do
      it 'renders the new template' do
        login_as(user, scope: :user)
        post movies_path, params: { movie: attributes_for(:movie, name: nil, user:) }
        expect(response).to render_template(:new)
      end
    end
  end
end
