
feature "registration page" do
  scenario "visitor sees a registration form" do
    visit '/users/new'
    expect(page).to have_button("Submit")
    expect(page).to have_content("Username")
    expect(page).to have_content("Password")
  end

  scenario "visitor fills in form to create an account" do
    fill_in_registration_form_and_submit
    # expect(page).to have_content("Thank you for registering")
    expect(page).to have_content("Thank you for registering.")
  end

  scenario "visitor fills in username but no password" do
    visit '/users/new'
    fill_in "Username", with: "Seth"
    # fill_in "password", with: ""
    click_on "Submit"
    expect(page).to have_content("Password is required")
    expect(page).to have_content("Register Here")
  end

  scenario "visitor fills in password but no username" do
    visit '/users/new'
    fill_in "Password", with: "seth"
    click_on "Submit"
    expect(page).to have_content("Username is required")
    expect(page).to have_content("Register Here")
  end

  scenario "visitor fills in neither password nor username" do
    visit '/users/new'
    click_on "Submit"
    expect(page).to have_content("Password and Username is required")
    expect(page).to have_content("Register Here")
  end



end