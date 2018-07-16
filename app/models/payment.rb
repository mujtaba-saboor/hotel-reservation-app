class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :reservation

  def process_payment(email, amount)
    # binding.pry
    customer = Stripe::Customer.create email: email,
                                       card: card_token

    Stripe::Charge.create customer: customer.id,
                          amount: amount.to_i * 100,
                          description: 'Payment',
                          currency: 'usd'
  end
end
