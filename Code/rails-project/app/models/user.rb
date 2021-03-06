class User < ActiveRecord::Base
  has_many :user_statuses

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true

  # Encrypt a plain text password using md5
  def self.encrypted_password(plain_text_password)
    Digest::MD5.hexdigest(plain_text_password)
  end
end
