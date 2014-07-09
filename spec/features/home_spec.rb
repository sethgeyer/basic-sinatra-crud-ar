feature "homepage" do

  before(:each) do
    visit "/"
  end

  scenario "visitor sees a Registration text" do
    expect(page).to have_content("Registration")
  end

  scenario "visitor sees a registration button" do
    expect(page).to have_link("Register")
  end

  scenario "visitor clicks Registration button and routes to Registration Page" do
    click_on "Register"
    expect(page).to have_content("Register Here")
  end

end