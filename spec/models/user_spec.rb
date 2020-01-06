require 'rails_helper'

describe User do
  describe '#create' do
    it 'nameが空での登録' do
      user = build(:user, name: "")
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'nameが"   "での登録' do
      user = build(:user, name: "   ")
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'emailが空での登録' do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it '無効なemailでの登録' do
      user = build(:user, email: "aaa")
      user.valid?
      expect(user.errors[:email]).to include("is invalid")
    end

    it 'nameが21文字での登録' do
      user = build(:user, name: "a"*21)
      user.valid?
      expect(user.errors[:name]).to include("is too long (maximum is 20 characters)")
    end
    
    it 'nameが20文字での登録' do
      user = build(:user, name: "a"*20)
      expect(user).to be_valid
    end

    it '同名の名前での登録' do
      user = create(:user)
      another = build(:user)
      another.valid?
      expect(another.errors[:name]).to include("has already been taken")
    end

  end
end