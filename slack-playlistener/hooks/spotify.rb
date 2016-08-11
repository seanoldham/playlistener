module SlackPlaylistener
  class Server < SlackRubyBot::Server
    on 'message' do |client, data|

      # # Authenticates Spotify App
      # # We don't want to auth each time a message appears, that's nuts!
      # # Commenting out until we find a better place to do this, probably initializers
      # def self.spotify_auth(pub, sec)
      #   puts 'Authenticating...'
      #   auth = RSpotify.authenticate(pub, sec)
      #   puts 'Authentication complete.' if auth
      # end

      # Find Track on Spotify
      def self.find_track(track_id, client, data)
        found_track = RSpotify::Track.find(track_id)

        # Right now it just spits it back out to Slack.
        # Eventually, this will add the song to a given playlist
        client.say(channel: data.channel, text: found_track.name)
      rescue
        puts track_id
        puts 'Invalid track ID. Please try again.'
      end

      # The Slack data, parsed to remove everything but the track ID
      if /track\//.match(data.text)
        # $' does this cool thing where it grabs everything behind the match.
        find_track($'[0..-2], client, data)
      else
        # Change this to 'stop process' or whatever the Ruby thing for that is
        puts 'No match...'
      end

      # spotify_auth(ENV['SPOTIFY_CLIENT'], ENV['SPOTIFY_SECRET'])

      # Do playlist stuff here

      # playlist = RSpotify::Playlist.find(ENV['PLAYLIST_AUTHOR'], ENV['PLAYLIST_ID'])
      # playlist.add_tracks!(['spotify:track:0w5BUiVv9SKELBWGuyQM3N'])

    end
  end
end
