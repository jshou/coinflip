require 'sinatra'
require 'yajl'
require 'redis'
Dir["#{settings.root}/lib/**/*.rb"].each { |f| require f }

require 'sinatra/reloader' if development?

require 'compass'
require 'sass'
require 'haml'

configure do
  set :haml, {:format => :html5, :escape_html => false}
  set :sass, {:style => :compact, :debug_info => false}
  # Compass.add_project_configuration(File.join(settings.root, 'config', 'compass.rb'))
end