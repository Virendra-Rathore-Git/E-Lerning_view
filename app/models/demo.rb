class User < ApplicationRecord

  has_secure_password

  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  enum status: { active: "active", inactive: "inactive" }, _default: "inactive"

  validates :name, presence: true
  validates :mobile, presence: true, uniqueness: true, length: { minimum: 10, maximum: 10 }
  validates :email, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9\-\.]+[@][a-z]+[\.][c][o][m]\z/, message: "Please Enter Email Like Example123@gmail.com" }
  around_save :msg_for_create

  def msg_for_create
   puts  "Successfully Create ---------------------- Before save"
    yield
   puts "Successfully Create ----------------------- after save"
  end
end
  
