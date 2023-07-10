class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :mobile, presence: true, uniqueness: true, length: { minimum: 10, maximum: 10 }
  validates :email, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9\-\.]+[@][a-z]+[\.][c][o][m]\z/, message: "Please Enter Email Like Example123@gmail.com" }
  validates :password, presence: true
  validates :type, inclusion: { in: ["Teacher", "Student"] }

  def Student?
    self.type == "Student"
  end

  def Teacher?
    self.type == "Teacher"
  end
end
