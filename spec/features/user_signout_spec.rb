require "rails_helper"

RSpec.feature "User Sign Out" do

  before do
    @john = User.create!(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password")
    visit new_user_session_path
    fill_in "Email", with: @john.email
    fill_in "Password", with: @john.password
    click_button "Log in"
  end

  scenario "with valid credentials" do
    visit "/"
    click_link "Sign out"

    expect(page).to have_content "Signed out successfully."
    expect(page).not_to have_content "SIgned in as #{@john.email}"
  end

end
