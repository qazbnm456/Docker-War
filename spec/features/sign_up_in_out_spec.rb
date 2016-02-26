require 'rails_helper'

feature 'Testing users\' functions: ', type: :feature do

  let(:user) { create :user }

  it 'let user sign up' do
    visit '/'
    click_link 'Sign up now!!'
    within('#new_user') do
      fill_in 'Name', :with => 'admin'
      choose 'Male', :match => :first
      fill_in 'Email', :with => 'admin@docker-war.com'
      fill_in 'Password', :with => 'thisisfortesting'
      fill_in 'Password confirmation', :with => 'thisisfortesting'
    end
    expect(Rails.logger).to receive(:info).with(match(/^[a-z0-9]+$/))
    click_button 'Register'
    expect(page).to have_http_status(200)
    expect(page).to have_content 'signed up successfully'
    expect(page).to have_content 'admin@docker-war.com'
  end

  it 'let user sign out' do
    visit '/login'
    within('#new_user') do
      fill_in 'Email', :with => 'admin@docker-war.com'
      fill_in 'Password', :with => 'thisisfortesting'
    end
    expect(Rails.logger).to receive(:info).with(match(/^[a-z0-9\s]+$/))
    click_button 'Log in'
    visit '/logout'
    expect(Rails.logger).to receive(:info).with("Deleting...")
    expect(page).to have_http_status(200)
    expect(page).to have_content 'Signed out successfully'
  end

  it 'let user sign in' do
    visit '/login'
    within('#new_user') do
      fill_in 'Email', :with => 'user1@docker-war.com'
      fill_in 'Password', :with => 'thisisfortesting'
    end
    expect(Rails.logger).to receive(:info).with(match(/^[a-z0-9]+$/))
    click_button 'Log in'
    expect(Rails.logger).to receive(:info).with("Passing PORT")
    expect(page).to have_http_status(200)
    expect(page).to have_content 'Signed in successfully'
  end
end
