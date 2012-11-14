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

  response.headers['Cache-Control'] = 'public, no-store, max-age=0'
  content_type :json
  Yajl.dump Flip.get(id)
end

post '/flip' do
  seconds =
    if params[:seconds_til_flip]
      halt 400, ":seconds_til_flip cannot be empty" if params[:seconds_til_flip].strip.empty?
      params[:seconds_til_flip].to_i
    elsif params[:minutes_til_flip]
      halt 400, ":minutes_til_flip cannot be empty" if params[:minutes_til_flip].strip.empty?
      params[:minutes_til_flip].to_i * 60
    else
      halt 400, "params must include :seconds_til_flip or :minutes_til_flip"
    end

  id = Flip.create(seconds)

  redirect "/#{id}"
end

get '/:id' do |id|
  redirect '/' unless Flip.exist? id
  haml(:show, locals: {id: id})
end
