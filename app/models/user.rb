class User < ActiveRecord::Base
  has_many :reservations, dependent: :destroy
  has_many :payments, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  Roles = [:admin, :default]

  def is?(requested_role)
    self.role == requested_role.to_s
  end

  # def confirmation_required?
  #   if self.role == ':admin'
  #     # debugger
  #     false
  #   else
  #     # debugger
  #     true
  #   end
  # end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_now
  end
end
