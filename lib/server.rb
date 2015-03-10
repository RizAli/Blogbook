require 'data_mapper'
require 'sinatra'
require 'rack-flash'

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
use Rack::Flash
use Rack::MethodOverride


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
  @user = User.new
  erb :"users/new"
end

get '/sessions/new' do
  erb :"sessions/new"
end

post '/users' do
  @user = User.new(:email => params[:email],
              :password => params[:password],
              :password_confirmation => params[:password_confirmation])
  if @user.save
    session[:user_id] = @user.id
    redirect to('/')
  else
    flash[:errors] = @user.errors.full_messages
    erb :"users/new"
  end
end

post '/sessions' do
  email, password = params[:email], params[:password]
  user = User.authenticate(email, password)
  if user
    session[:user_id] = user.id
    redirect to('/')
  else
    flash[:errors] = ["The email or password is incorrect"]
    erb :"sessions/new"
  end
end

delete '/sessions' do
  flash[:notice] = "Good bye!"
  session[:user_id] = nil
  erb :"sessions/new"
end







