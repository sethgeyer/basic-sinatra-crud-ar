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
    fill_in_registration_form_and_submit("Seth")
    user_logs_in
    expect(page).to have_content("Welcome Seth!")
    expect(page).to have_content("Logout")
    expect(page).not_to have_link("Login")
    expect(page).not_to have_link("Register")
  end

  scenario "user logs out" do
    fill_in_registration_form_and_submit("Seth")
    #save_and_open_page
    user_logs_in
    click_on "Logout"
    expect(page).to have_link("Register")
  end

  scenario "user logs in and sees other users ONLY" do
    fill_in_registration_form_and_submit("Seth")
    fill_in_registration_form_and_submit("Stu")
    user_logs_in
    expect(page).to have_content("Stu")
    visit "/"
    expect(page).not_to have_content("Seth")
  end

  scenario "user can display users in acending or decending order" do
    fill_in_registration_form_and_submit("Ben")
    fill_in_registration_form_and_submit("Seth")
    fill_in_registration_form_and_submit("Stu")
    fill_in_registration_form_and_submit("Abe")
    user_logs_in
    click_on "ASC"
    expect(page).to have_content("Abe\nBen\nStu")
    click_on "DESC"
    expect(page).to have_content("Stu\nBen\nAbe")
  end

  scenario "logged in user can delete other users" do
    fill_in_registration_form_and_submit("Seth")
    fill_in_registration_form_and_submit("Adam")
    user_logs_in
    expect(page).to have_content("Adam")
    click_on "Adam"
    expect(page).not_to have_content("Adam")
  end

  scenario "logged in user can see a fish header and a link to add fish" do
    fill_in_registration_form_and_submit("Seth")
    expect(page).not_to have_content("Fish")
    user_logs_in
    expect(page).to have_content("Fish")
    expect(page).to have_link("Add Fish")
  end

  scenario "logged in user can add a fish" do
    fill_in_registration_form_and_submit("Seth")
    user_logs_in
    click_on "Fish"
    fill_in "Name", with: "Mackerel"
    fill_in "URL", with: "http://en.wikipedia.org/wiki/Mackerel"
    click_on "Submit"
    expect(page).to have_link("Mackerel")
    click_link "Mackerel"
    expect(page).to have_content("Mackerel typically have vertical stripes on their backs and deeply forked tails.")
  end

end