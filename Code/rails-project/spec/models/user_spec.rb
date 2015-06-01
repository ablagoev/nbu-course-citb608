require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'encrypted_password' do
    it 'encrypts a plain text password using the md5 algorithm' do
      expect(User.encrypted_password('test')).to eq('098f6bcd4621d373cade4e832627b4f6')
    end
  end

  it 'validates email presence' do
    user = User.new(password: User.encrypted_password('123456'), name: 'Test')

    expect(user.valid?).to eq(false)
  end

  it 'validates password presence' do
    user = User.new(email: 'test@example.com', name: 'Test')

    expect(user.valid?).to eq(false)
  end

  it 'validates uniqueness of email' do
    User.create(email: 'test@example.com', password: User.encrypted_password('123456'), name: 'Test')

    user = User.new(email: 'test@example.com', password: User.encrypted_password('asdfg'), name: 'Test2')
    expect(user.valid?).to eq(false)
  end
end
