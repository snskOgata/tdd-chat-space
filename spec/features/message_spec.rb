require 'rails_helper'

feature 'message', type: :feature do

  scenario 'root_pathにアクセス' do
    visit root_path
    expect(page).to have_content('Hello')
  end
end