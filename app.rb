require 'sinatra/base'
require 'eyeson'
require 'faker'
require 'securerandom'

# Configuration of the rubygem "eyeson"
Eyeson.configure do |config|
config.api_key = ENV['EYESON_API_KEY']
end

# Application Main
class EyesonQuickstartApp < Sinatra::Base

# Root endpoint listening on the HTTP GET method and rendering the content
# of views/index.erb
get '/' do
erb :index
end

# Join endpoint, joins the user to the video meeting room and redirects the
# client to the web GUI.
get '/join' do
redirect Eyeson::Room.join(
  id: 'ruby-quickstart',
  name: 'Ruby Quickstart Room',
  user: {
    id: SecureRandom.uuid, # unique identifier for each user
    name: Faker::BojackHorseman.character, # random username
    avatar: Faker::Avatar.image # random avatar image URL
  },
  options: {
    recording_available: false, # disallow recording of the meeting
    broadcast_available: false, # disallow broadcasting of the meeting
    exit_url: "https://#{request.host}/" # set return point
  }
).url # directly return the web GUI URL from result to the redirect method
end

run! if app_file == $0
end
