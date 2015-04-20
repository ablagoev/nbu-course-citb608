class User < ActiveRecord::Base
  def self.encrypted_password(plain_text_password)
    Digest::MD5.hexdigest(plain_text_password)
  end
end
