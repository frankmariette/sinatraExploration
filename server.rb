require 'sinatra'

get '/' do
	erb :index, :layout => true
end

get '/rickroll' do
	erb :rick, :layout => true
end

get '/posts/:id' do
	"You are reading post #{params[:id]}"
end