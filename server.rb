require 'sinatra'
require 'digest'
require 'mongo_mapper'
require 'rack/contrib'

class Person
  include MongoMapper::Document

  key :fname, String, required: true
  key :lname, String, required: true
  key :username, String, unique: true, required: true
  key :email, String, required: true
  key :password, String, required: true
    
end

configure do
  MongoMapper.database = 'exploration2'
  I18n.config.enforce_available_locales = false
end

get '/' do
	erb :index, :layout => true
end

get '/new' do
	erb :new, { :layout => true }
end

get '/users' do
	@person = Person.all
	erb :list, :layout => true, :locals => { user: @person }
end

get '/users/:id' do
  @person = Person.where( :username => params[:id] )
  erb :user, layout: true, locals: { user: @person}
end

get '/users/:id/delete' do
  if Person.destroy_all( :username => params[:id] )
    redirect to('/users') 
  else
    redirect('/users/:id')
  end
end

post '/users' do
  password_hash = Digest::SHA256.hexdigest params[:password]
  person = Person.new(fname: params[:fname], lname: params[:lname], username: params[:username], email: params[:email], password: password_hash)
  if person.save
    redirect to('/users')
  else
    redirect to('/new'), "User couldn't be created"
  end
end






