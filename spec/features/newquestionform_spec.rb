require 'rails_helper'

feature 'User creates a new question' do
  given(:user) {User.create!(username: "Bob Rajput", email: Faker::Internet.email, password: "123")}

  scenario 'can click outside of form and hide it', js: true do
    visit '/'
    click_link("Login")
    within(".new_user") do
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button("Login")
    end
    click_link("Ask a Question")
    page.execute_script('$(document.elementFromPoint(0, 0)).click();')
    expect(page).to have_no_content("Submit New Question")
  end
end