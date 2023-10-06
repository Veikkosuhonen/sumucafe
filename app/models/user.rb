class User < ApplicationRecord
  has_secure_password

  validates :username, uniqueness: true,
            length: { minimum: 3 }

  validates :email, uniqueness: true

end
