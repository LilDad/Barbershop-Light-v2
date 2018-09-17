require 'rubygems'
require 'sinatra'

get '/' do
	erb :main
end

get '/contacts' do
  erb :contacts
end

post '/contacts' do

  @user_email = params[:user_email]
  @user_message = params[:user_message]

  output = File.open "./public/contacts.txt", "a+"
  output.write "User email: #{@user_email}, user message: #{@user_message}\n"
  output.close

  erb :contacts_confirm
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
  @user_data = params[:user_data]
  @user_time = params[:user_time]
  @master = params[:master]

  output = File.open "./public/users.txt", "a+"
  output.write "First name: #{@first_name}, last name: #{@last_name}, time: #{@user_data }, date: #{@user_time}, master: #{@master}\n"
  output.close

  erb :visit_confirm
end
