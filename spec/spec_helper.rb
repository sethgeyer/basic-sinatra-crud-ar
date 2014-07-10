require_relative "./../app"
require "capybara/rspec"
ENV["RACK_ENV"] = "test"

Capybara.app = App

database_connection = DatabaseConnection.establish(ENV["RACK_ENV"])

RSpec.configure do |config|
  config.before do
    database_connection.sql("BEGIN")
  end

  config.after do
    database_connection.sql("ROLLBACK")
  end
end


def fill_in_registration_form_and_submit
  visit '/users/new'
  fill_in "Username", with: "Seth"
  fill_in "Password", with: "seth"
  click_on "Submit"
end

def fill_in_registration_form_for_another_dude
  visit '/users/new'
  fill_in "Username", with: "Stu"
  fill_in "Password", with: "stu"
  click_on "Submit"
end


def user_logs_in
  fill_in "Username", with: "Seth"
  fill_in "Password", with: "seth"
  click_on "Submit"
end




# def clear_test_dbase
#   @dummy = DatabaseConnection.new(ENV["RACK_ENV"])
#   @dummy.sql("DELETE FROM users WHERE id>0 ")
# end
