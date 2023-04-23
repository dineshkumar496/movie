# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie, type: :model do
  context 'is valid' do
    it 'should valid if length of name is between 1-50' do
      movie = Movie.new(name: 'movie', release_date: Date.today)
      expect(movie).to be_valid
    end
  end

  context 'is not valid' do
    it 'should not be valid if name is empty' do
      movie = Movie.new(name: '', release_date: Date.today)
      expect(movie).to_not be_valid
    end
    it 'should not be valid if name length is grater than 50' do
      movie = Movie.new(
        name: 'asdfghjklpoiuytrewqasdfghjklpoiuyytewdcghffrtyuhgfdfghjhgfdfghgfghjhgfghjhgfghgfghgfgrthrfhjhsdfsdaghgjh', release_date: Date.today
      )
      expect(movie).to_not be_valid
    end
    it 'should not be valid if name is empty' do
      movie = Movie.new(name: 'cghmdgh', release_date: '')
      expect(movie).to_not be_valid
    end
  end
end
