require 'rails_helper'

describe Group do
  describe '#create' do
    it 'nameが空での登録' do
      group = build(:group, name: "")
      group.valid?
      expect(group.errors[:name]).to include("を入力してください")
    end

    it 'nameが"   "での登録' do
      group = build(:group, name: "   ")
      group.valid?
      expect(group.errors[:name]).to include("を入力してください")
    end

    it 'nameを31字での登録' do
      group = build(:group, name: "a"*31)
      group.valid?
      expect(group.errors[:name]).to include("は30文字以内で入力してください")
    end


    it 'nameを30字での登録' do
      group = build(:group, name: "a"*30)
      expect(group).to be_valid
    end

    it 'グループにメンバーが一人もいない場合' do
      group = build(:group, users: [])
      group.valid?
      expect(group.errors[:users]).to include("は1人以上必要です")
    end
  end
end