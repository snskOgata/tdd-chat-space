require 'rails_helper'

describe User do
  describe '#create' do
    it '無効なnameでの登録' do
      user.build(:user, name: "")
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    it '無効なemailでの登録' do
      user.build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end
  end
end