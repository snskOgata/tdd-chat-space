require 'rails_helper'

describe MessagesController do
  describe 'GET #index' do
    it "indexビューの描画" do
      get :index
      expect(response).to render_template :index
    end
  end
end