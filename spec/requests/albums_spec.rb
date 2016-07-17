require 'rails_helper'

RSpec.describe "Albums" do
  it 'checks albums listing content' do
  	visit(albums_path)
  	page.should have_content('Listing Albums')
  end
end