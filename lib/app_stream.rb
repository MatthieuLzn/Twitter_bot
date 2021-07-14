    require 'twitter'
        require 'dotenv'


    Dotenv.load('../.env')

def streaming_connection
    @client_stream = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end
    return @client_stream
end

def rest_connection
    client_rest = Twitter::REST::Client.new do |config|
     config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
     config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
     config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
     config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end
    return client_rest
  end


    #Affiche les tweet en rapport avec le "tracks"
    def tracker(tracks)
      @client.filter(track: tracks) do |object|
        puts object.text if object.is_a?(Twitter::Tweet)
        sleep(10)
      end
    end
    
    #Like les tweet en rapport avec le "tracks"
    def liker2(track)
        streaming_connection.filter(track: track) do |object|
            puts object.text if object.is_a?(Twitter::Tweet)
            rest_connection.fav object # favorite the tweet
            sleep(10)
        end
    end

    def follow_mamene(track)
        streaming_connection.filter(track: track) do |object|
            puts object.text if object.is_a?(Twitter::Tweet)
            rest_connection.follow object.user 
        end
    end
            

