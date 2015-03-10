require 'spec_helper'

feature "User browses the list of links" do

  before(:each) {
    Blog.create(:url => "http://www.makersacademy.com/",
                :title => "Makers Blog"
                )
  }
  scenario "when opening the home page" do
    visit '/'
    expect(page).to have_content("Makers Blog")
  end


end