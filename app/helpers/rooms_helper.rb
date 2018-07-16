module RoomsHelper
  def room_no?(room_number)
    room_number = room_number.split('-')[1]
  end
end
