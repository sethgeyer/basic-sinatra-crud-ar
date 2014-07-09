
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



end