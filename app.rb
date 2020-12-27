
require 'sinatra/base'
require 'eyeson'
require 'faker'
require 'securerandom'

Eyeson.configure do |config|
  config.api_key = ENV[RYU1zY7P9fRWsE37qGacfjiAxGizFQTSJY3CfQq5ff]
end

class EyesonQuickstartApp < Sinatra::Base

  get '/' do
    erb :index
  end

  get '/join' do
    redirect Eyeson::Room.join(
      id: 'ruby-quickstart',
      name: 'Ruby Quickstart Room',
      user: {
        id: SecureRandom.uuid,
        name: Faker::BojackHorseman.character,
        avatar: Faker::Avatar.image
      },
      options: {
        recording_available: false,
        broadcast_available: false,
        exit_url: "https://#{request.host}/"
      }
    ).url
  end

  run! if app_file == $0
end
