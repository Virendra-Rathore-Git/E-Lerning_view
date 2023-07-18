class User < ApplicationRecord
  has_secure_password

  enum status: { active: "active", inactive: "inactive" }, _default: "inactive"

  validates :name, presence: true
  validates :mobile, presence: true, uniqueness: true, length: { minimum: 10, maximum: 10 }
  validates :email, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9\-\.]+[@][a-z]+[\.][c][o][m]\z/, message: "Please Enter Email Like Example123@gmail.com" }
  validates :password, presence: true

end
