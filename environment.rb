require 'sinatra'
require 'yajl'
require 'redis'
Dir["#{settings.root}/lib/**/*.rb"].each { |f| require f }

require 'sinatra/reloader' if development?
