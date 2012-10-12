require 'sinatra'
require 'yajl'
require './environment'

get '/' do
  haml :index
end

get '/flip/:id' do |id|
  halt 404 unless Flip.exist? id

  request.accept.each do |type|
    case type
    when 'text/html'
      haml(:show, locals: {id: id})
    when 'text/json'
      content_type :json
      Yajl.dump Flip.get(id)
    end
  end
end

post '/flip' do
  seconds = params[:seconds_til_flip]
  halt 400, ":seconds_til_flip cannot be blank" if seconds.nil? || seconds.strip.empty?

  Flip.create(seconds)

  redirect "/flip/#{id}"
end
