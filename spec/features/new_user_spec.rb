
feature "registration page" do
  scenario "visitor sees a registratio form" do
    visit '/users/new'
    expect(page).to have_button("Register")
  end
end