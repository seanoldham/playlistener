module SlackPlaylistener
  class Server < SlackRubyBot::Server
    on 'message' do |client, data|

      # Authenticates Spotify App
      def self.spotify_auth(pub, sec)
        puts 'Authenticating...'
        auth = RSpotify.authenticate(pub, sec)
        puts 'Authentication complete.' if auth
      end

      # Find Track on Spotify
      def self.find_track(track_id, client, data)
        found_track = RSpotify::Track.find(track_id)
        client.say(channel: data.channel, text: found_track.name)
      rescue
        puts track_id
        puts 'Invalid track ID. Please try again.'
      end

      spotify_auth(ENV['SPOTIFY_CLIENT'], ENV['SPOTIFY_SECRET'])

      # The Slack data, parsed to remove everything but the track ID
      if /track\//.match(data.text)
        id = $'
        id = id[0..-2]
        find_track(id, client, data)
      else
        # Change this to 'stop process' or whatever the Ruby thing for that is
        puts "No match..."
      end

      # Do playlist stuff here

      # playlist = RSpotify::Playlist.find(ENV['PLAYLIST_AUTHOR'], ENV['PLAYLIST_ID'])
      # playlist.add_tracks!(['spotify:track:0w5BUiVv9SKELBWGuyQM3N'])

    end
  end
end
