require_relative "./../app"
require "capybara/rspec"
ENV["RACK_ENV"] = "test"

Capybara.app = App


def fill_in_registration_form_and_submit
visit '/users/new'
fill_in "Username", with: "Seth"
fill_in "Password", with: "seth"
click_on "Submit"
end


def user_logs_in
  fill_in "Username", with: "Seth"
  fill_in "Password", with: "seth"
  click_on "Submit"
end