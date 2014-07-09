
feature "registration page" do
  scenario "visitor sees a registration form" do
    visit '/users/new'
    expect(page).to have_button("Submit")
    expect(page).to have_content("Username")
    expect(page).to have_content("Password")
  end

  scenario "visitor fills in form to create an account" do
    visit '/users/new'
    fill_in "Username", with: "Seth"
    fill_in "Password", with: "seth"
    click_on "Submit"
    # expect(page).to have_content("Thank you for registering")
    expect(page).to have_content("Thank you for registering.")

  end



end