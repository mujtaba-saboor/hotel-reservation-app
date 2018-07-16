class HotelsController < ApplicationController
  before_action :date_present?, only: :show
  before_action :user_signed_in?, only: [:index, :show, :search]
  before_action :admin_user, only: [:index, :create, :new]

  def index
    @hotels = Hotel.all.paginate(page: params[:page], per_page: 2)
  end

  def new
    @hotel = Hotel.new
  end

  def destroy
    Hotel.find(params[:id]).destroy
    flash[:success] = 'Hotel deleted'
    redirect_to hotels_url
  end

  def create
    @hotel = Hotel.new(hotel_params)
    if @hotel.save
      flash[:success] = 'Hotel added!'
      redirect_to hotels_path
    else
      render 'new'
    end
  end

  def search
    @selected_hotels = []
    flag = 0
    skip = 0
    params[:check_in] = DateTime.strptime(params[:check_in], '%m/%d/%Y %H:%M %p')
    params[:check_out] = DateTime.strptime(params[:check_out], '%m/%d/%Y %H:%M %p')
    session[:check_in] = params[:check_in]
    session[:check_out] = params[:check_out]
    if params[:city].present?
      @hotels = Hotel.where(country: params[:country]).where(city: params[:city])
    else
      @hotels = Hotel.where(country: params[:country])
    end
    @hotels.each do |hotel|
      hotel.rooms.each do |room|
        if room.reservations.empty?
          @selected_hotels.push(hotel) unless @selected_hotels.include?(hotel)
          break
        else
          room.reservations.each do |reservation|
            next if reservation.date_to < DateTime.now
            if (reservation.date_from > params[:check_in] && reservation.date_from > params[:check_out]) || (reservation.date_to < params[:check_in] && reservation.date_to < params[:check_out]) || !reservation.booked
              flag = 0
            else
              flag = 1
              break
            end
          end
          if flag == 0
            @selected_hotels << hotel
            skip = 1
            break 
          end
        end
        if skip == 1
          skip = 0
          break
        end
      end
    end
    if @selected_hotels.empty?
      flash[:danger] = 'No hotels found, change search parameters'
      if can? :manage, User 
        redirect_to(:back)
        else
        redirect_to root_url
      end
    end  
  end

  def show
    @selected_rooms = []
    flag = 0
    @check_in ||= session[:check_in]
    @check_out ||= session[:check_out]
    @hotel = Hotel.find(params[:id])
    @hotel.rooms.each do |room|
      if room.reservations.empty?
        @selected_rooms << room
        next
      else
        room.reservations.each do |y|
          next if y.date_to < DateTime.now
          if (y.date_from >@check_in && y.date_from > @check_out) || (y.date_to < @check_in && y.date_to < @check_out) || !y.booked
            flag = 0
          else
            flag = 1
            break
          end
        end
        if flag == 0
          @selected_rooms << room
          next
        end
      end
    end
  end

private

  def date_present?
    if session[:check_in].nil?
      begin
      flash[:danger] = 'Kindly enter check in and check out dates first'
      hotel = Hotel.find(params[:id])
      session[:country] = hotel.country
      session[:city] = hotel.city
      redirect_to root_url
    rescue => e
      flash[:danger] = e.message
      redirect_to root_url
    end
    end
  end

  def admin_user
    redirect_to root_url unless current_user.role == 'admin'
  end

  def hotel_params
      params.require(:hotel).permit(:name, :country, :city, :street, :picture, :picture_file_name, :picture_content_type)
  end

end
