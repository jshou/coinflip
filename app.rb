require 'sinatra'
require './environment'

get '/' do
  haml :index
end

get '/style.css' do
  sass :style
end

get '/flip/:id' do |id|
  halt 404 unless Flip.exist? id

  content_type :json
  Yajl.dump Flip.get(id)
end

post '/flip' do
  seconds = params[:seconds_til_flip]
  halt 400, ":seconds_til_flip cannot be blank" if seconds.nil? || seconds.strip.empty?

  id = Flip.create(seconds)

  redirect "/#{id}"
end

get '/:id' do |id|
  redirect '/' unless Flip.exist? id
  haml(:show, locals: {id: id})
end
