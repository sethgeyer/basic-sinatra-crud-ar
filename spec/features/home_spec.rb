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

end