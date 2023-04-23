# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  before do
    user = User.first
    movie = Movie.new(name: 'movie', release_date: Date.today)
    @review = Review.new(body: 'reviews')
    @review.user = user
    @review.movie = movie
  end

  context 'should be valid' do
    it 'should contain some text' do
      expect(@review).to be_valid
    end
  end

  context 'should not be valid' do
    it 'not valid if it does not have any text' do
      @review.body = ''
      expect(@review).to_not be_valid
    end

    it ' not valid if it does not have user ' do
      @review.user = nil
      expect(@review).to_not be_valid
    end

    it ' not valid if it does not have movie associated with it ' do
      @review.movie = nil
      expect(@review).to_not be_valid
    end
  end
end
