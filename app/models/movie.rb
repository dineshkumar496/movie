class Movie < ApplicationRecord

  has_many :ratings , :dependent => :delete_all
  has_many :reviews , :dependent => :delete_all

  #validations
  validates :name , length: {in: 1..50}

  #scopes
  # changing default scope to return in the order of max rated movie first
  default_scope { order(average_rating: :desc)}

  #Scope for filtering movies using release date
  scope :filter_by_date, lambda { |start_date|
    where(release_date: start_date)
  }

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end

end
