class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :room
  belongs_to :hotel
  has_one :reservation
  has_one :payment
end
