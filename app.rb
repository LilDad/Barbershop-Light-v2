require 'rubygems'
require 'sinatra'

get '/' do
	erb :main
end

get '/contacts' do
  erb :contacts
end

get '/about' do
  erb :about
end

get '/visit' do
  erb :visit
end

get '/test' do
  erb "404"
end