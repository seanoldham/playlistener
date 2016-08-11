module SlackPlaylistener
  module Commands
    # Just a test command to see how it works
    class Goodnight < SlackRubyBot::Commands::Base
      command 'goodnight' do |client, data, _match|
        client.say(channel: data.channel, text: ':wave:')
      end
    end
  end
end
