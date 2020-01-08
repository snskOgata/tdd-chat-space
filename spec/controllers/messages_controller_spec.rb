require 'rails_helper'

describe MessagesController do
  let(:group) { create(:group) }
  let(:user) { create(:user) }

  describe '#index' do

    context 'ログイン状態' do
      before do
        login user
      end
      it 'indexにアクセス' do
        get :index
        expect(response).to render_template :index
      end
    end

    context '非ログイン状態' do
      it 'indexにアクセス→ログイン画面へ' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

  end

  describe '#create' do
    let(:params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message) } }

    context 'ログイン状態' do
      before do
        login user
      end

      context 'メッセージ送信' do
        subject {
          post :create,
          params: params
        }

        it 'メッセージ送信完了' do
          expect{ subject }.to change(Message, :count).by(1)
        end

        it 'グループページにリダイレクト' do
          subject
          expect(response).to redirect_to(group_messages_path(group))
        end
      end

      context '送信失敗' do
        let(:invalid_params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message, content: nil, image: nil) } }

        subject {
          post :create,
          params: invalid_params
        }

        it 'DBに追加されない' do
          expect{ subject }.not_to change(Message, :count)
        end

        it 'グループページを表示' do
          subject
          expect(response).to render_template :index
        end
      end
    end

    context '非ログイン状態' do

      it 'ログイン画面へ' do
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end