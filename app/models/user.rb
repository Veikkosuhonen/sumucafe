class User < ApplicationRecord
  has_secure_password

  validates :username, uniqueness: true,
            length: { minimum: 3 }

  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password, confirmation: true, length: { minimum: 4, maximum: 50 }, on: :create

  before_create do
    generate_token(:auth_token)
  end

  def generate_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save
  end

  def send_password_reset
    generate_password_reset
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
