require "rails_helper"

RSpec.feature "User Sign  In" do

  before do
    @john = User.create!(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password")
  end

  scenario "with valid credentials" do
    visit "/"
    click_link "Sign in"

    fill_in "Email", with: @john.email
    fill_in "Password", with: @john.password
    click_button "Log in"

    expect(page).to have_content "Signed in successfully."
    expect(page).to have_content "Signed in as #{@john.email}"
    expect(page).to have_link "Sign out"
    expect(page).not_to have_link "Sign in"
    expect(page).not_to have_link "Sign up"
  end
end
