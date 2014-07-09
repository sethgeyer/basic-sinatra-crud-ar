feature "homepage" do

  before(:each) do
    visit "/"
  end

  scenario "visitor sees a registration button" do
    expect(page).to have_link("Register")
  end

  scenario "visitor does not see the login form" do
    expect(page).not_to have_link("Logout")
  end

  scenario "visitor clicks Registration button and routes to Registration Page" do
    click_on "Register"
    expect(page).to have_content("Register Here")
  end

  scenario "visitor see a login text" do
    expect(page).to have_content("Login")
  end

  scenario "visitor fills in login credentials and logs in" do
    fill_in_registration_form_and_submit
    user_logs_in
    expect(page).to have_content("Welcome Seth!")
    expect(page).to have_content("Logout")
    expect(page).not_to have_link("Login")
    expect(page).not_to have_link("Register")
  end

  scenario "user logs out" do
    fill_in_registration_form_and_submit
    user_logs_in
    click_on "Logout"
    expect(page).to have_link("Register")
  end

end