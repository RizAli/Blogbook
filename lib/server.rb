require 'data_mapper'
require 'sinatra'

env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, "postgres://localhost/blogbook_#{env}")

require 'blog'
DataMapper.finalize

DataMapper.auto_upgrade!
set:views, Proc.new { File.join(root,"/views")}


get '/' do
  @blogs = Blog.all
  erb :index
end
