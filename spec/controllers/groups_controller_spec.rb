require 'rails_helper'

describe GroupsController do
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

  describe '#new' do

    context 'ログイン状態' do
      before do
        login user
      end
      it 'newにアクセス' do
        get :new
        expect(response).to render_template :new
      end
    end

    context '非ログイン状態' do
      it 'indexにアクセス→ログイン画面へ' do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end