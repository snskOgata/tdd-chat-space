require 'rails_helper'

describe Message do
  describe '#create' do
    it 'contentとimageが空での登録' do
      message = build(:message, content: "", image: "")
      message.valid?
      expect(message.errors[:content]).to include("を入力してください")
    end

    it 'contentが空でimageは有りでの登録' do
      message = build(:message, content: "")
      expect(message).to be_valid
    end

    it 'contentもimageも有りでの登録' do
      message = build(:message, content: "")
      expect(message).to be_valid
    end
  end
end
