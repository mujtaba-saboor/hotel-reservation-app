module ReservationsHelper
  def status(id)
    Reservation.find(id).booked ? 'Currently booked' : 'Checked out'
  end

  def room(id)
    Room.find(id).room_no
  end

  def hotel1(id)
    Hotel.find(id).name
  end

  def hotel2(id)
    Hotel.find(id).city
  end
  
  def hotel3(id)
    Hotel.find(id).country
  end

  def true?(id)
    Reservation.find(id).booked ? false : true
  end
end
