# spec/features/admin_dashboard_spec.rb
require 'rails_helper'

RSpec.feature "Admin Dashboard", type: :feature do
  scenario "displays the dashboard" do
    admin_user = AdminUser.create(email: "admin@example.com", password: "password", password_confirmation: "password")

    visit new_admin_user_session_path
    fill_in "Email", with: admin_user.email
    fill_in "Password", with: admin_user.password
    click_button "Log in"

    visit admin_root_path
    expect(page).to have_content("Welcome to Active Admin")
  end
end
