require 'sinatra'
# require 'redis'

get '/' do
  haml :index
end

get '/flip/:id' do |id|
  "Flip id: #{id}!"
end

post '/flip' do
  seconds = params[:seconds_til_flip]
  if seconds.nil? || seconds.strip.empty?
    status 400
    return ":seconds_til_flip cannot be blank"
  end

  id = SecureRandom.hex 4
  # redis.
end

def redis
	@redis ||= Redis.new
end

def json_body
  request.body.rewind # in case it has already been read
  Yajl.load request.body.read
end
