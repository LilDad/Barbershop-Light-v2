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

  output = File.open './public/contacts.txt', 'a+'
  output.write "User email: #{@user_email}, user message: #{@user_message}\n"
  output.close

  erb :contacts_confirm
end

get '/about' do
  @error = "testim"
  erb :about
end

get '/visit' do
  erb :visit
end

get '/test' do
  erb '404'
end

get '/login' do
  erb :login
end

post '/login' do
  @login = params[:login]
  @password = params[:password]

  if @login == 'admin' && @password == '123123'
    erb 'Logged'
  else
    erb 'Access denied!'
  end
end

post '/visit' do
  @first_name = params[:first_name]
  @last_name = params[:last_name]
  @user_data = params[:user_data]
  @user_time = params[:user_time]
  @barber = params[:barber]
  @colorpicker = params[:colorpicker]


  hh = {:first_name => 'Enter first name',
        :last_name => 'Enter last name',
        :user_data => 'Choice data',
        :user_time => 'Choice time',
        :master => 'Choice master',
        :colorpicker => 'Enter color'}

  hh.each do |key, value|
    if params[key] == ''
      @error = hh[key]
      return erb :visit
    end
  end

  erb "Ok, first name is #{@first_name}, last name: #{@last_name}, time: #{@user_data}, date: #{@user_time}, master: #{@barber}, hair color: #{@colorpicker}"

  output = File.open './public/users.txt', 'a+'
  output.write "First name: #{@first_name}, last name: #{@last_name}, time: #{@user_data}, date: #{@user_time}, master: #{@barber}, hair color: #{@colorpicker}\n"
  output.close
end
