require 'rails_helper'

feature 'message', type: :feature do

  scenario 'root_pathにアクセス' do
    visit root_path
    expect(response).to render_template :index
  end
end