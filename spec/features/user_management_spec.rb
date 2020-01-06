require 'rails_helper'
 RSpec.feature "User Management", :devise do

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

  scenario "名前を編集" do
    user = build(:user)
    # ユーザ登録
    sign_up_with(user.name, user.email, user.password, user.password_confirmation)
    expect(page).to have_content(user.name)
    # ユーザエディットのリンクをクリック
    click_link 'edit-user'
    expect(page).to have_content("Edit User")
    expect(find('#user_name').value).to eq(user.name)
    
    # passwordが空白のまま更新
    fill_in "user_name", with: "NewName"
    fill_in "user_current_password", with: ""
    click_button "Update"
    expect(page).to have_content("現在のパスワードを入力してください")
    # 誤ったパスワードで更新
    fill_in "user_name", with: "NewName"
    fill_in "user_current_password", with: "wrong password"
    click_button "Update"
    expect(page).to have_content("現在のパスワードは不正な値です")
    # 名前を空で更新
    fill_in "user_name", with: ""
    fill_in "user_current_password", with: user.password
    click_button "Update"
    expect(page).to have_content("Nameを入力してください")

    # 21文字の名前で更新
    visit edit_user_registration_path
    fill_in "user_name", with: "a"*21
    fill_in "user_current_password", with: user.password
    click_button "Update"
    expect(page).to have_content("Nameは20文字以内で入力してください")
    # 正しい名前、正しいパスワードで登録
    visit edit_user_registration_path
    fill_in "user_name", with: "NewName"
    fill_in "user_current_password", with: user.password
    click_button "Update"
    expect(page).to have_content("NewName")
    
  end
end