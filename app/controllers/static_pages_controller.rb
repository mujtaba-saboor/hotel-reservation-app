class StaticPagesController < ApplicationController
  def home
    @hotels = Hotel.all.paginate(page: params[:page], per_page: 4) unless current_user.nil?
    session.delete(:check_in)
    session.delete(:check_out)
  end

  def help;  end

  def about;  end

  def contact;  end
end
