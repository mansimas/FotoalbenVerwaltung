require 'rails_helper'

RSpec.describe 'Albums index functionality' do
	before(:each) do
		DatabaseCleaner.clean
		visit(root_path)
		click_on('register')
		fill_in('Email', with: 'myemail@email.com')
		fill_in('Password', with: 'mypassword')
		fill_in('Password confirmation', with: 'mypassword')
		fill_in('Name', with: 'firstName')
		click_on('Sign up')
		album = Album.create!(title: 'Albumblahblah', description: 'Albums description', user_id: 1)
		Photo.create!(album_id: album.id, photo_file_name: '1234image.png')
		Photo.create!(album_id: album.id, photo_file_name: '5678image.png')
	end

	it 'shows first image near title' do
		visit(albums_path)
		page.should have_xpath("//img[@src=\"/assets/images/1234image.png\"]")
	end

	it 'shows correct buttons for logged in users' do
		visit(albums_path)
		page.should have_content('Show')
		page.should have_content('Edit')
		page.should have_content('Destroy')
		page.should have_content('New Album')
	end

	it 'shows correct buttons for not logged in users' do
		click_on('sign out')
		page.should have_no_content('Edit')
		page.should have_no_content('Destroy')
		page.should have_no_content('New Album')
	end

	it 'shows albums title and user name' do 
		visit(root_path)
		page.should have_content('Albumblahblah')
		page.should have_content('firstName')
	end

end