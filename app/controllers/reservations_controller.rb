class ReservationsController < ApplicationController
  before_action :admin_user, only: :my_bookings

  def new; end

  def my_bookings
    @reservations = Reservation.where(user_id: current_user.id).paginate(page: params[:page], per_page: 6).order(booked: :desc).order(date_to: :desc)
  end

  def check_out
    reservation = Reservation.find(params[:format])
    reservation.booked = false
    reservation.save
    redirect_to my_bookings_path
  end

  def destroy
    Reservation.find(params[:id]).destroy
    flash[:success] = 'Reservation canceled'
    redirect_to(:back)
  end

private

  def admin_user
    redirect_to(root_url) if can? :manage, User
  end

end
