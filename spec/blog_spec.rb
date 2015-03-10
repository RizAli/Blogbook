require 'spec_helper'

describe Blog do

  context 'Check that the database and datamapper is working' do

    it'should be created and retrieved from the db' do
      expect(Blog.count).to eq 0
      Blog.create(title: 'Makers Blog',
                  url: 'http://www.makersacademy.com/')
      expect(Blog.count).to eq 1
      blog = Blog.first
      expect(blog.url).to eq 'http://www.makersacademy.com/'
      expect(blog.title).to eq 'Makers Blog'
      blog.destroy
      expect(Blog.count).to eq 0
    end





  end

end