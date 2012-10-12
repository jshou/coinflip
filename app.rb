require 'sinatra'

get '/' do
  haml :index
end

get '/flip/:id' do |id|
  "Flip id: #{id}!"
end

post '/flip' do
  "posted to flip"
end
