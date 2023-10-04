class User < ApplicationRecord
  validates :username, uniqueness: true,
            length: { minimum: 3 }

  validates :email, uniqueness: true

end
