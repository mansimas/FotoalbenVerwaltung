require 'rails_helper'
RSpec.describe 'Albums Show Functionality' do
	before(:each) do
		DatabaseCleaner.clean
		visit(root_path)
		click_on('register')
		fill_in("Email", with: 'gaga@gaga.lt')
		fill_in("Password", with: 'password1')
		fill_in("Password confirmation", with: 'password1')
		fill_in("Name", with: 'somename')
		click_on("Sign up")
		Album.create!(:title => 'some title', :description => 'some description', :user_id => 1)
		Photo.create!(:album_id => 1, :photo_file_name => '1234image.png')
		Photo.create!(:album_id => 1, :photo_file_name => '5678image.png')
	end

	it 'should have correct title,user name and description on page' do
		visit(root_path)
		click_on('Show')
		page.should have_content('some title')
		page.should have_content('created of: somename')
		page.should have_content('some description')
		page.should have_xpath("//img[@src=\"/assets/images/5678image.png\"]")
		page.should have_xpath("//img[@src=\"/assets/images/1234image.png\"]")
	end

	it 'should give ability to comment album for logged in users' do
		visit(edit_album_path(1))
		page.should has_xpath?("//textarea[@id='comment_description']")
	end

	it 'should not give ability to comment album for not logged in users' do
		click_on('sign out')
		page.should have_content('log in')
		visit(root_path)
		click_on('Show')
		page.should have_no_xpath("//textarea[@id='comment_description']")
	end

	it 'should add comment to comments list after commenting' do
		visit(root_path)
		click_on('Show')
		fill_in('comment_description', with: 'some random text')
		click_on('Submit')
		page.should have_content('some random text')
		expect(Comment.where(:description => 'some random text')).to be_present
	end

end






