module HotelsHelper
  def date_entered
    true if session[:check_in].present?
  end

  def date_time?(t)
    t.to_datetime.strftime("%a, %B %d, %Y %T %P")
  end

  def link_value(hotel)
    if current_user.role == 'admin' && session[:check_in].nil?
      rooms_path(id: hotel.id)
    else
      hotel
    end
  end
end
