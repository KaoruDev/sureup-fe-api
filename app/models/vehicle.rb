class Vehicle < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :year, :make, :model, :nickname
end
