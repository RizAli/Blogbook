require 'spec_helper'

feature "User adds a new blog" do

  scenario "when browsing the homepage" do
    expect(Blog.count).to eq(0)
    visit '/'
    add_blog("http://www.makersacademy.com/", "Makers Academy")
    expect(Blog.count).to eq(1)
    blog = Blog.first
    expect(blog.url).to eq("http://www.makersacademy.com/")
    expect(blog.title).to eq("Makers Academy")
  end

  def add_blog(url, title)
    within('#new-blog') do
      fill_in 'url', :with => url
      fill_in 'title', :with => title
      click_button 'Add Blog'
    end
  end
end