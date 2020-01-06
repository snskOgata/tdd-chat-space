module Features

  module SessionHelpers

    def sign_up_with(name, email, password, confirmation)
      visit new_user_registration_path
      fill_in "user_name", with: name
      fill_in "user_email", with: email
      fill_in "user_password", with: password
      fill_in "user_password_confirmation", with: confirmation
      click_button "Create Account"
    end

    def sign_in(email, password)
      visit new_user_session_path
      fill_in "Email", with: email
      fill_in "Password", with: password
      click_button "Log in"
    end
  end
end