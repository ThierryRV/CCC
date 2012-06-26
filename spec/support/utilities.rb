
def full_title(page_title)
  base_title = "C.C.C."
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def valid_signin(user)
  fill_in "Email",    with: user.email
  fill_in "Mot de passe", with: user.password
  click_button "Se connecter"
end

def sign_in(user)
  visit signin_path
  fill_in "Email", with: user.email
  fill_in "Mot de passe", with: user.password
  click_button "Se connecter"
# Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-error', text: message)
  end
end