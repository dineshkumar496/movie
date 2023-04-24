# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :ratings, dependent: :destroy
  has_many :reviews, dependent: :destroy

  after_create :welcome_user

  private

  def welcome_user
    WelcomeUserJob.perform_later(self)
  end
end
