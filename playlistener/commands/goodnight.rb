class Goodnight < SlackRubyBot::Commands::Base
  command 'goodnight' do |client, data, _match|
    client.say(channel: data.channel, text: ':wave:')
  end
end
