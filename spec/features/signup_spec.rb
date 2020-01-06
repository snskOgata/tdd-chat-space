require 'rails_helper'
 RSpec.feature "Sign Up", :devise do

  scenario "種々の名前で登録" do
    user = build(:user)
    # 名前を空欄で登録
    sign_up_with("", user.email, user.password, user.password_confirmation)
    expect(page).to have_content("Nameを入力してください")

    # 名前を"   "で登録
    sign_up_with("   ", user.email, user.password, user.password_confirmation)
    expect(page).to have_content("Nameを入力してください")

    # 名前を21字で登録
    sign_up_with("a"*21, user.email, user.password, user.password_confirmation)
    expect(page).to have_content("Nameは20文字以内で入力してください")

    #　正しい名前で登録
    sign_up_with(user.name, user.email, user.password, user.password_confirmation)
    expect(page).to have_content(user.name)
  end
end