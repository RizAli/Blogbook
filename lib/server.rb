require 'data_mapper'

env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, "postgres://localhost/blogbook_#{env}")

require 'blog'
DataMapper.finalize

DataMapper.auto_upgrade!