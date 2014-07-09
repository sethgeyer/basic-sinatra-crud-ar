feature "homepage" do

  before(:each) do
    visit "/"
  end

  scenario "visitor sees a registration button" do
    expect(page).to have_link("Register")
  end

  scenario "visitor clicks Registration button and routes to Registration Page" do
    click_on "Register"
    expect(page).to have_content("Register Here")
  end

  scenario "visitor see a login text" do
    expect(page).to have_content("Login")
  end

  scenario "visitor fills in login credentials and logs in" do
    visit '/users/new'
    fill_in "Username", with: "Seth"
    fill_in "Password", with: "seth"
    click_on "Submit"
    fill_in "Username", with: "Seth"
    fill_in "Password", with: "seth"
    click_on "Submit"
    expect(page).to have_content("Welcome Seth!")
  end

end