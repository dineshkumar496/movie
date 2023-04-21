class Movie < ApplicationRecord
  has_many :ratings , :dependent => :delete_all
  has_many :reviews , :dependent => :delete_all
end
