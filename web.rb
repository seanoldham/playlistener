require 'sinatra/base'

module SlackPlaylistener
  class Web < Sinatra::Base
    get '/' do
      'Good night!'
    end
  end
end
