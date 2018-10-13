require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def get_db
  SQLite3::Database.new 'Barbershop.sqlite'
end

configure do
  db = get_db
  db.execute 'CREATE TABLE IF NOT EXISTS
    "users"
    (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "first_name" VARCHAR,
    "last_name" VARCHAR,
    "datetime" VARCHAR,
    "barber" VARCHAR,
    "color" VARCHAR
    )'
end

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
  @error = 'testim'
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

get '/showusers' do
  db = get_db

  @results = db.execute 'select * from users order by id desc --;'

    erb :showusers
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
  @user_datetime = params[:user_datetime]
  @barber = params[:barber]
  @colorpicker = params[:colorpicker]

  hh = { first_name: 'Enter first name',
         last_name: 'Enter last name',
         user_datetime: 'Choice date and time',
         master: 'Choice master',
         colorpicker: 'Enter color' }

  @error = hh.select { |key, _| params[key] == '' }.values.join(', ')

  return erb :visit if @error != ''

  db = get_db
  db.execute 'insert into users (first_name, last_name, datetime, barber, color) values (?, ?, ?, ?, ?)',
              [@first_name, @last_name, @user_datetime, @barber, @colorpicker]

  erb "Ok, first name is #{@first_name},
           last name: #{@last_name},
           date and time: #{@user_datetime},
           master: #{@barber},
           hair color: #{@colorpicker}"

  # output = File.open './public/users.txt', 'a+'
  # output.write "First name: #{@first_name},
  #                    last name: #{@last_name},
  #                    time: #{@user_date},
  #                    date: #{@user_time},
  #                    master: #{@barber},
  #                    hair color: #{@colorpicker}\n"
  # output.close
end