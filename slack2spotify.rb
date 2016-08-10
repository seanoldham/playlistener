require 'rspotify'
require_relative 'secret'

# Creates New Track Input
class TrackInput
  attr_accessor :id

  def initialize(id)
    @id = id
  end
end

# Authenticates Spotify App
def spotify_auth(pub, sec)
  puts 'Authenticating...'
  RSpotify.authenticate(pub, sec)
  puts 'Authentication complete.'
end

# Find Track on Spotify
def find_track(track_id)
  found_track = RSpotify::Track.find(track_id)
  found_track.artists.each do |a|
    puts "#{a.name}: #{found_track.name}"
  end
rescue
  puts track_id
  puts 'Invalid track ID. Please try again.'
end

spotify_auth(@spotify_client, @spotify_secret)


# The received data from Slack
message_from_slack = 'https://open.spotify.com/track/1hTUFqJuQAMjXVGwUPWDqi'

# The Slack data, parsed to remove everything but the track ID
if /track\//.match(message_from_slack)
  slack_input = TrackInput.new($')
  find_track(slack_input.id)
else
  # Change this to 'stop process' or whatever the Ruby thing for that is
  puts "No match..."
end
