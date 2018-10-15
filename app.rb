require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def get_db
  SQLite3::Database.new 'Barbershop.sqlite'
end

def if_barber_exist?(db, name)
  !db.execute('select * from Barbers where barber_name=?', [name]).empty?
end

def seed_db(db, barbers)
  barbers.each do |barber|
    unless if_barber_exist? db, barber
      db.execute 'insert into Barbers (barber_name) values (?)', [barber]
    end
  end
end

before do
  db = get_db
  db.results_as_hash = true
  @barbers_results = db.execute 'select * from Barbers;'
end

configure do
  db = get_db
  db.execute 'CREATE TABLE IF NOT EXISTS
    "Users"
    (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "first_name" VARCHAR,
    "last_name" VARCHAR,
    "datetime" VARCHAR,
    "barber" VARCHAR,
    "color" VARCHAR
    )'
  db.execute 'CREATE TABLE IF NOT EXISTS
    "Barbers"
    (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "barber_name" VARCHAR,
    CONSTRAINT UC_Barbers UNIQUE (barber_name)
    )'
  seed_db db, ['Jessie Pinkman', 'Walter White', 'Gus Fring', 'Mike Ehrmantraut']
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

get '/test' do
  erb '404'
end

get '/login' do
  erb :login
end

get '/showusers' do
  db = get_db
  db.results_as_hash = true
  @results = db.execute 'select * from Users order by id desc --;'

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

get '/visit' do
  erb :visit
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
         barber: 'Choice master',
         colorpicker: 'Enter color' }

  @error = hh.select { |key, _| params[key] == '' }.values.join(', ')

  return erb :visit if @error != ''

  db = get_db
  db.execute 'insert into Users (first_name, last_name, datetime, barber, color) values (?, ?, ?, ?, ?)',
             [@first_name, @last_name, @user_datetime, @barber, @colorpicker]

  erb "Ok, first name is #{@first_name},
           last name: #{@last_name},
           date and time: #{@user_datetime},
           barber: #{@barber},
           hair color: #{@colorpicker}"
end
