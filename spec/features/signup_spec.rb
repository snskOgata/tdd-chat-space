require 'rails_helper'
 RSpec.feature "Sign Up", :devise do

  scenario "visitor cannot sign up with invalid email address" do
    sign_up_with("email", "password", "password")

    expect(page).to have_content("Eメールは不正な値です")
  end

  scenario "visitor cannot sign up without password" do
    sign_up_with("test@example.com", "", "")

    expect(page).to have_content("パスワードを入力してください")
  end

  scenario "visitor cannot sign up with a short password" do
    sign_up_with("test@example.com", "1234", "1234")

    expect(page).to have_content("パスワードは6文字以上で入力してください")
  end

  scenario "visitor cannot sign up without password confirmation" do
    sign_up_with("test@example.com", "password", "")

    expect(page).to have_content("パスワードの入力が一致しません")
  end

  scenario "visitor cannot sign up with mismatched password and confirmation" do
    sign_up_with("test@example.com", "password", "mismatch")

    expect(page).to have_content("パスワードの入力が一致しません")
  end
end