require 'rails_helper'

RSpec.describe UserStatus, type: :model do
  it 'validates status minimum length' do
    status = UserStatus.new(status: 'a')

    expect(status.valid?).to eq(false)
  end

  it 'validates status maximum length' do
    status = UserStatus.new(status: 'a' * 800)

    expect(status.valid?).to eq(false)
  end
end
