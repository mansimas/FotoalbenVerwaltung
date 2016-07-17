require 'rails_helper'

RSpec.describe "Navigation" do
  it 'checks albums main buttons' do
  	visit(root_path)
  	click_on('Albums')
  	page.should have_content('Listing Albums')
  end
  it 'checks login button' do
  	visit(root_path)
  	click_on('log in')
  	page.should have_content('Log in')
  end
  it 'checks register button' do
  	visit(root_path)
  	click_on('register')
  	page.should have_content('Sign up')
  end
  it 'checks sign out button' do
  	visit(root_path)
  	click_on('register')
  	fill_in('Email', with: 'John@johner.lt')
  	fill_in('Password', with: 'Johnathan1')
  	fill_in('Password confirmation', with: 'Johnathan1')
  	click_on('Sign up')
  	click_on('sign out')
  	click_on('log in')
  	fill_in('Email', with: 'John@johner.lt')
  	fill_in('Password', with: 'Johnathan1')
  	click_on('Log in')
  	page.should have_content('Signed in successfully.')
  end
end
