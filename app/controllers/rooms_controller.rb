class RoomsController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create, :destroy, :reserve]
  before_action :admin_user, only: [:index, :new, :create, :destroy]

  def index
    @hotel_id = params[:format].nil? ? params[:id] : params[:format]
    @rooms = Room.where(hotel_id: @hotel_id).order('room_no')
  end

  def new
    @hotel_id = params[:format]
    @room = Room.new
  end

  def create
    params[:room][:room_no] = "#{params[:room][:hotel_id]}-#{params[:room][:room_no]}"
    @room = Room.new(room_params)
    if @room.save
      flash[:success] = 'Room added!'
      redirect_to rooms_path(params[:room][:hotel_id])
    else
      flash[:danger] = 'Room no already taken!'
      redirect_to new_room_path(params[:room][:hotel_id])
    end
  end

  def destroy
    Room.find(params[:id]).destroy
    flash[:success] = 'Room deleted'
    redirect_to(:back)
  end

private

  def room_params
    params.require(:room).permit(:category, :room_no, :price, :hotel_id)
  end

  def admin_user
    unless current_user.role == 'admin'
      flash[:warning] = 'restricted page, cannot access!'
      redirect_to root_url
    end
  end
end
