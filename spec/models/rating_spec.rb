# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rating, type: :model do
  before do
    user = User.create!(email: 'aaa@gmail.com', password: '123456')
    movie = Movie.new(name: 'movie', release_date: Date.today)
    @rating = Rating.new(star: 5)
    @rating.user = user
    @rating.movie = movie
  end

  context 'should be valid' do
    it 'if contains star value' do
      expect(@rating).to be_valid
    end
  end

  context 'should not be valid' do
    it 'not valid if star value not present' do
      @rating.star = ''
      expect(@rating).to_not be_valid
    end

    it ' not valid if rating value is more the=an 5' do
      @rating.star = 10
      expect(@rating).to_not be_valid
    end

    it ' not valid if rating does not have movie id' do
      @rating.movie = nil
      expect(@rating).to_not be_valid
    end
    it ' not valid if rating does not have user associated with it' do
      @rating.user = nil
      expect(@rating).to_not be_valid
    end
  end

  describe 'callbacks' do
    context 'should update average rating' do
      it 'if new rating was created ' do
        expect(@rating).to receive(:update_average_rating)
        @rating.save
      end

      it 'if rating was updated' do
        @rating.save
        @rating.update(star: 3)
        expect(@rating).to receive(:update_average_rating)
        @rating.save
      end
    end
  end
end
