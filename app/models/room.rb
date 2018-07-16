class Room < ActiveRecord::Base
  belongs_to :hotel
  has_many :reservations, dependent: :destroy
  validates :room_no, uniqueness: true
end
