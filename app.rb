require 'sinatra'

get '/' do
  'i am a robot. i cannot see'
end

get '/flip/:id' do |id|
  "Flip id: #{id}!"
end

post '/flip' do
  "posted to flip"
end
