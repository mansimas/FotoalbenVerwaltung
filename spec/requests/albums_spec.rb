require 'rails_helper'

RSpec.describe "Albums" do

  before(:each) do
  	DatabaseCleaner.clean
    visit(root_path)
  	click_on('register')
  	fill_in('Email', with: 'John@johner.lt')
  	fill_in('Password', with: 'Johnathan1')
  	fill_in('Password confirmation', with: 'Johnathan1')
  	click_on('Sign up')
  end

  it 'checks albums listing content' do
  	visit(albums_path)
  	page.should have_content('Listing Albums')
  end

  it 'checks new album functionality' do
  	visit(albums_path)
  	click_on('New Album')
  	page.should have_content('Album management')
  end

  it 'checks new album title functionality' do
  	visit(albums_path)
  	click_on('New Album')
  	page.should have_content('Title:')
  	fill_in('album_title', with: 'Albums Title Nr 1')
  	click_on('Update Album')
  	page.should have_content('Album was successfully updated.')
  	page.should have_content('Albums Title Nr 1')
  end

  it 'checks new album description functionality' do
  	visit(albums_path)
  	click_on('New Album')
  	fill_in('album_description', with: 'Albums Description Nr 1')
  	click_on('Update Album')
  	page.should have_content('Album was successfully updated.')
  	page.should have_content('Albums Description Nr 1') 
  end 

  it 'checks new album file upload via dropzone functionality', :js => true do
  	visit(albums_path)
  	click_on('New Album') 
  	drop_in_dropzone Rails.root + 'spec/image.png'
  	sleep(1)
  	click_on('Update Album') 
  	page.should have_content('Album was successfully updated.')
  	image_name = Album.last.photos.last.photo_file_name
  	page.should have_xpath("//img[@src=\"/assets/images/#{image_name}\"]")
  end

  def drop_in_dropzone(file_path)
	  page.execute_script <<-JS
	    fakeFileInput = window.$('<input/>').attr(
	      {id: 'fakeFileInput', type:'file'}
	    ).appendTo('body');
	  JS
	  attach_file("fakeFileInput", file_path)
	  page.execute_script("var fileList = [fakeFileInput.get(0).files[0]]")
	  page.execute_script <<-JS
	    var e = jQuery.Event('drop', { dataTransfer : { files : fileList } });
	    $('.dropzone')[0].dropzone.listeners[0].events.drop(e);
	  JS
  end
end