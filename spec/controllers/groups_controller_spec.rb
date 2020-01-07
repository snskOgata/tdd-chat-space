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

  describe '#create' do
    let(:params) { { group: attributes_for(:group, user_ids: [user.id]) } }
    context 'ログイン状態' do
      before do
        login user
      end
      it "データベースに新しいグループが登録" do
        expect{
          post :create, params: params
        }.to change(Group, :count).by(1)
      end
    end

    context '非ログイン状態' do
      it "データベースに新しいグループが登録" do
        expect{
          post :create, params: params
        }.to change(Group, :count).by(0)
      end
    end
  end

  describe '#edit' do

    context 'ログイン状態' do
      before do
        login user
      end
      it 'newにアクセス' do
        get :edit, params: {id: group.id}
        expect(response).to render_template :edit
      end
    end

    context '非ログイン状態' do
      it 'indexにアクセス→ログイン画面へ' do
        get :edit, params: {id: group.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe '#update' do
    context 'ログイン状態' do
      before do
        login user
      end
      it "グループ情報をアップデート" do
        patch :update, params: { id: group.id.to_i,  group:  {name: "new_name", user_ids: group.user_ids} }
        expect(group.reload.name).to eq "new_name"
      end
    end

    context '非ログイン状態' do
      it "グループ情報はアップデートされない" do
        old_name = group.name
        patch :update, params: { id: group.id.to_i,  group:  {name: "new_name", user_ids: group.user_ids} }
        expect(group.reload.name).to eq old_name
      end
    end
  end
end