class User < ActiveRecord::Base
  has_many :user_statuses
  def self.encrypted_password(plain_text_password)
    Digest::MD5.hexdigest(plain_text_password)
  end
end
