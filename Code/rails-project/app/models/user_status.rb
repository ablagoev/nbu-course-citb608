class UserStatus < ActiveRecord::Base
  belongs_to :user

  validates :status, presence: true
  validates :status, length: { minimum: 5, maximum: 300 }
end
