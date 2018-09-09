require 'rubygems'
require 'sinatra'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
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