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

post '/visit' do
  @first_name = params[:first_name]
  @last_name = params[:last_name]
  output = File.open "public/users.txt", "w"
  output.write @first_name
  output.close
end