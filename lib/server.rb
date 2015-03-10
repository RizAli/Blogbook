require 'data_mapper'
require 'sinatra'

env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, "postgres://localhost/blogbook_#{env}")

require_relative 'blog'
require_relative 'user'
DataMapper.finalize

DataMapper.auto_upgrade!

set :root, File.dirname(__FILE__)
set :views, Proc.new { File.join(root,"/views")}
enable :sessions
set :session_secret, 'super secret'

helpers do

  def current_user
    @current_user ||=User.get(session[:user_id]) if session[:user_id]
  end

end




get '/' do
  @blogs = Blog.all
  erb :index
end

post '/blogs' do
  url = params['url']
  title = params['title']
  Blog.create(:url => url, :title => title)
  redirect to ('/')
end

get '/users/new' do
  erb :"users/new"
end

post '/users' do
  user = User.create(:email => params[:email],
              :password => params[:password])
  session[:user_id] = user.id
  redirect to('/')
end