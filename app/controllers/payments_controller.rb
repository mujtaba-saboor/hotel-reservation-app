class PaymentsController < ApplicationController
  before_action :dates_entered?

  def new
    @payment = Payment.new
    @rooms_for_reservation = params[:room]
    @check_in = session[:check_in]
    @check_out = session[:check_out]
    d1 = DateTime.strptime(@check_in, '%Y-%m-%dT%H:%M:%S')
    d2 = DateTime.strptime(@check_out, '%Y-%m-%dT%H:%M:%S')
    no_of_days = (d2 - d1).to_i
    @total_price = 0
    @rooms_for_reservation.each do |room|
      @total_price += Room.find(room).price * no_of_days
    end
    @hotel_id = params[:id]
    @user_id = current_user.role == 'admin' ? session[:user] : current_user.id
  end

  def create
    reservation_id = Reservation.maximum('id') + 1
    user_id = params[:payment][:user_id]
    @payment = Payment.new payment_params.merge(card_token: stripe_params['stripeToken'], user_id: user_id, reservation_id: reservation_id)
    raise 'Please, check registration errors' unless @payment.valid?
    email = User.find(user_id).email
    total_price = params[:payment][:amount]
    @payment.process_payment(email, total_price)
    @payment.save
    rooms_for_reservation = params[:payment][:rooms_for_reservation].split
    hotel_id = params[:payment][:hotel_id]
    check_in = params[:payment][:check_in]
    check_out = params[:payment][:check_out]
    rooms_for_reservation.each do |room|
      Reservation.create(date_from: check_in,
                         date_to: check_out,
                         user_id: user_id,
                         room_id: room,
                         hotel_id: hotel_id,
                         booked: 1)
    end
    flash[:success] = 'Payment successfully submitted!'
    redirect_to my_bookings_path
  rescue => e
    flash[:danger] = e.message
    redirect_to(:back)
  end

  def reserve; end

  private

  def payment_params
    params.require(:payment).permit(:full_name, :telephone, :amount)
  end

  def stripe_params
    params.permit :stripeEmail, :stripeToken
  end

  def customer?
    redirect_to(root_url) if can? :manage, User
  end

  def dates_entered?
    redirect_to(root_url) if session[:check_in].nil?
  end
end
